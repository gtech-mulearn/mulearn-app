import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/models/location_option.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/profile/domain/entities/editable_profile.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/college_change_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/editable_profile_controller.dart';

const _months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

/// Personal info plus an optional college change: two backend calls
/// (`PATCH .../profile/` and `PATCH .../college/change-college/`) behind one
/// Save, matching the reference dashboard's single modal. A form sheet.
class EditProfileSheet extends ConsumerStatefulWidget {
  const EditProfileSheet({required this.profile, super.key});

  final UserProfile profile;

  /// Opens the sheet over [context].
  static Future<void> show(BuildContext context, UserProfile profile) =>
      showMuSheet<void>(context, builder: (_) => EditProfileSheet(profile: profile));

  @override
  ConsumerState<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends ConsumerState<EditProfileSheet> {
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  String _dob = '';
  String? _gender;
  Set<String> _communities = {};
  bool _prefilled = false;
  bool _saving = false;

  String? _countryId;
  String? _stateId;
  String? _districtId;
  String? _orgId;
  String? _departmentId;

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _mobile.dispose();
    super.dispose();
  }

  static const _genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];

  /// The backend doesn't guarantee returning gender in the casing it was
  /// saved with (`"male"` for `"Male"`). Mirrors the reference dashboard's
  /// `normalizeGenderValue`: anything unrecognized maps to `null`.
  static String? _normalizeGender(String? value) {
    final raw = (value ?? '').trim().toLowerCase();
    if (raw.isEmpty) return null;
    for (final option in _genderOptions) {
      if (option.toLowerCase() == raw) return option;
    }
    return null;
  }

  void _prefill(EditableProfile editable) {
    if (_prefilled) return;
    _prefilled = true;
    _fullName.text = editable.fullName.isNotEmpty ? editable.fullName : widget.profile.fullName;
    _email.text = editable.email;
    _mobile.text = editable.mobile;
    _gender = _normalizeGender(editable.gender.isNotEmpty ? editable.gender : widget.profile.gender);
    _dob = editable.dob;
    _communities = editable.communities.toSet();
    _districtId = editable.district?.id;
    _stateId = editable.district?.state.id;
    _countryId = editable.district?.state.country.id;
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_dob) ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked == null) return;
    setState(
      () => _dob =
          '${picked.year.toString().padLeft(4, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.day.toString().padLeft(2, '0')}',
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      // The backend rejects an empty `dob` ("Date has wrong format"), unlike
      // mobile/gender which accept "" — so an unset DOB is omitted, not blank.
      final dob = _dob.trim();
      await ref
          .read(editableProfileControllerProvider.notifier)
          .save(
            fullName: _fullName.text.trim(),
            email: _email.text.trim(),
            mobile: _mobile.text.trim(),
            gender: _gender,
            dob: dob.isEmpty ? null : dob,
            communities: _communities.toList(),
          );

      if (_orgId != null && _departmentId != null) {
        await ref.read(changeCollegeControllerProvider.notifier).submit(orgId: _orgId!, departmentId: _departmentId!);
      }

      if (mounted) {
        MuToast.show(context, message: 'Profile saved', type: MuToastType.success);
        Navigator.of(context).pop();
      }
    } on Object catch (e) {
      if (mounted) {
        MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final editableState = ref.watch(editableProfileControllerProvider)..whenData(_prefill);
    final department = editableState.value?.department?.title;
    final dob = DateTime.tryParse(_dob);

    if (editableState.isLoading && !_prefilled) {
      return const SizedBox(
        height: 280,
        child: Center(child: MuDotsLoader(label: 'Loading your details…')),
      );
    }

    return MuFormSheet(
      title: 'Edit profile',
      lead: 'Your name shows on your profile, leaderboards and certificates.',
      action: MuButton(label: 'Save', block: true, loading: _saving, onPressed: _saving ? null : _save),
      children: [
        MuTextField(
          label: 'Full name',
          controller: _fullName,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
        ),
        MuTextField(
          label: 'Email',
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
        ),
        MuTextField(
          label: 'Mobile',
          controller: _mobile,
          keyboardType: TextInputType.phone,
          autofillHints: const [AutofillHints.telephoneNumber],
        ),
        MuSelectField(
          label: 'Gender',
          value: _gender,
          options: [for (final o in _genderOptions) MuOption(o, o)],
          onChanged: (value) => setState(() => _gender = value),
        ),
        Semantics(
          button: true,
          label: 'Date of birth, ${dob == null ? 'not set' : _long(dob)}',
          excludeSemantics: true,
          onTap: _pickDob,
          child: MuFieldChrome(
            label: 'Date of birth',
            onTap: _pickDob,
            trailing: SizedBox.square(
              dimension: MuSizes.touchMin,
              child: Icon(LucideIcons.calendar, size: 20, color: c.ink3),
            ),
            child: Text(
              dob == null ? 'Add your birthday' : _long(dob),
              style: mu.text.body.copyWith(fontSize: 16, color: dob == null ? c.ink3 : c.ink),
            ),
          ),
        ),
        MuFormSection(
          'College',
          note: ['Now: ${widget.profile.collegeCode ?? 'not set'}', if (department != null) department].join(' · '),
        ),
        Text(
          'Moved? Pick your new college and department. Leave these alone to keep the current one.',
          style: mu.text.caption.copyWith(color: c.ink2),
        ),
        ..._collegeFields(),
      ],
    );
  }

  static String _long(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

  List<Widget> _collegeFields() {
    final countries = ref.watch(profileCountriesProvider);
    final states = _countryId == null ? null : ref.watch(profileStatesProvider(_countryId!));
    final districts = _stateId == null ? null : ref.watch(profileDistrictsProvider(_stateId!));
    final orgs = _districtId == null ? null : ref.watch(organizationsAndDepartmentsProvider(_districtId!));

    List<MuOption> places(List<LocationOption>? list) => [
      for (final o in list ?? const <LocationOption>[]) MuOption(o.id, o.name),
    ];
    List<MuOption> refs(List<ReferenceOption>? list) => [
      for (final o in list ?? const <ReferenceOption>[]) MuOption(o.id, o.title),
    ];

    return [
      MuSelectField(
        label: 'Country',
        value: _countryId,
        loading: countries.isLoading,
        options: places(countries.value),
        onChanged: (id) => setState(() {
          _countryId = id;
          _stateId = _districtId = _orgId = _departmentId = null;
        }),
      ),
      MuSelectField(
        label: 'State',
        value: _stateId,
        enabled: _countryId != null,
        loading: states?.isLoading ?? false,
        options: places(states?.value),
        onChanged: (id) => setState(() {
          _stateId = id;
          _districtId = _orgId = _departmentId = null;
        }),
      ),
      MuSelectField(
        label: 'District',
        value: _districtId,
        enabled: _stateId != null,
        loading: districts?.isLoading ?? false,
        options: places(districts?.value),
        onChanged: (id) => setState(() {
          _districtId = id;
          _orgId = _departmentId = null;
        }),
      ),
      MuSelectField(
        label: 'College or school',
        value: _orgId,
        enabled: _districtId != null,
        loading: orgs?.isLoading ?? false,
        options: refs(orgs?.value?.organizations),
        onChanged: (id) => setState(() => _orgId = id),
      ),
      MuSelectField(
        label: 'Department',
        value: _departmentId,
        enabled: _districtId != null,
        loading: orgs?.isLoading ?? false,
        options: refs(orgs?.value?.departments),
        onChanged: (id) => setState(() => _departmentId = id),
      ),
    ];
  }
}
