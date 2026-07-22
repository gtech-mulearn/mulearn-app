import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/models/location_option.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/core/widgets/searchable_select_field.dart';
import 'package:mulearn_app/features/profile/domain/entities/editable_profile.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/college_change_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/editable_profile_controller.dart';

/// Personal-info form + an optional "change college" section — two distinct
/// backend calls (`PATCH .../profile/` and `PATCH .../college/change-college/`)
/// behind one Save action, matching the reference dashboard's single modal.
class EditProfileDialog extends ConsumerStatefulWidget {
  const EditProfileDialog({required this.profile, super.key});

  final UserProfile profile;

  @override
  ConsumerState<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _dob = TextEditingController();
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
    _dob.dispose();
    super.dispose();
  }

  static const _genderOptions = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  /// `DropdownButtonFormField` crashes with a failed assertion if its value
  /// doesn't exactly match one of its items — but the backend doesn't
  /// guarantee returning gender in the same casing it was saved with (e.g.
  /// `"male"` instead of `"Male"`), confirmed by this exact crash on a real
  /// device. Mirrors the reference dashboard's `normalizeGenderValue`:
  /// anything unrecognized maps to `null` rather than being passed through.
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
    _fullName.text = editable.fullName.isNotEmpty
        ? editable.fullName
        : widget.profile.fullName;
    _email.text =
        editable.email.isNotEmpty ? editable.email : (widget.profile.email ?? '');
    _mobile.text = editable.mobile.isNotEmpty
        ? editable.mobile
        : (widget.profile.mobile ?? '');
    _gender = _normalizeGender(
      editable.gender.isNotEmpty ? editable.gender : widget.profile.gender,
    );
    _dob.text = editable.dob;
    _communities = editable.communities.toSet();
    _districtId = editable.district?.id;
    _stateId = editable.district?.state.id;
    _countryId = editable.district?.state.country.id;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      // The backend validates `dob` as a date and rejects an empty string
      // outright (confirmed live: `""` → 400 "Date has wrong format"), unlike
      // mobile/gender which accept `""` fine — so an unset DOB must be
      // omitted entirely, not sent blank.
      final dob = _dob.text.trim();
      await ref.read(editableProfileControllerProvider.notifier).save(
            fullName: _fullName.text.trim(),
            email: _email.text.trim(),
            mobile: _mobile.text.trim(),
            gender: _gender,
            dob: dob.isEmpty ? null : dob,
            communities: _communities.toList(),
          );

      if (_orgId != null && _departmentId != null) {
        await ref.read(changeCollegeControllerProvider.notifier).submit(
              orgId: _orgId!,
              departmentId: _departmentId!,
            );
      }

      if (mounted) Navigator.of(context).pop();
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
    final editableState = ref.watch(editableProfileControllerProvider)
      ..whenData(_prefill);

    return AlertDialog(
      title: const Text('Edit profile'),
      content: SizedBox(
        width: 480,
        child: editableState.isLoading && !_prefilled
            ? const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Basic info', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _fullName,
                      decoration: const InputDecoration(labelText: 'Full name'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _email,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _mobile,
                      decoration: const InputDecoration(labelText: 'Mobile'),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _gender,
                      decoration: const InputDecoration(labelText: 'Gender'),
                      items: [
                        for (final option in _genderOptions)
                          DropdownMenuItem(value: option, child: Text(option)),
                      ],
                      onChanged: (value) => setState(() => _gender = value),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _dob,
                      decoration: const InputDecoration(
                        labelText: 'Date of birth',
                        hintText: 'YYYY-MM-DD',
                      ),
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.tryParse(_dob.text) ??
                              DateTime(2000),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          _dob.text =
                              '${picked.year.toString().padLeft(4, '0')}-'
                              '${picked.month.toString().padLeft(2, '0')}-'
                              '${picked.day.toString().padLeft(2, '0')}';
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Text('College / school',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      'Current: ${widget.profile.collegeCode ?? '—'}'
                      '${widget.profile.departmentName != null ? ' · ${widget.profile.departmentName}' : ''}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    _CollegeChangeSection(
                      countryId: _countryId,
                      stateId: _stateId,
                      districtId: _districtId,
                      orgId: _orgId,
                      departmentId: _departmentId,
                      onCountryChanged: (id) => setState(() {
                        _countryId = id;
                        _stateId = null;
                        _districtId = null;
                        _orgId = null;
                        _departmentId = null;
                      }),
                      onStateChanged: (id) => setState(() {
                        _stateId = id;
                        _districtId = null;
                        _orgId = null;
                        _departmentId = null;
                      }),
                      onDistrictChanged: (id) => setState(() {
                        _districtId = id;
                        _orgId = null;
                        _departmentId = null;
                      }),
                      onOrgChanged: (id) => setState(() => _orgId = id),
                      onDepartmentChanged: (id) =>
                          setState(() => _departmentId = id),
                    ),
                  ],
                ),
              ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}

class _CollegeChangeSection extends ConsumerWidget {
  const _CollegeChangeSection({
    required this.countryId,
    required this.stateId,
    required this.districtId,
    required this.orgId,
    required this.departmentId,
    required this.onCountryChanged,
    required this.onStateChanged,
    required this.onDistrictChanged,
    required this.onOrgChanged,
    required this.onDepartmentChanged,
  });

  final String? countryId;
  final String? stateId;
  final String? districtId;
  final String? orgId;
  final String? departmentId;
  final ValueChanged<String?> onCountryChanged;
  final ValueChanged<String?> onStateChanged;
  final ValueChanged<String?> onDistrictChanged;
  final ValueChanged<String?> onOrgChanged;
  final ValueChanged<String?> onDepartmentChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countries = ref.watch(profileCountriesProvider);
    final states = countryId == null
        ? null
        : ref.watch(profileStatesProvider(countryId!));
    final districts =
        stateId == null ? null : ref.watch(profileDistrictsProvider(stateId!));
    final orgsAndDepartments = districtId == null
        ? null
        : ref.watch(organizationsAndDepartmentsProvider(districtId!));

    return Column(
      children: [
        SearchableSelectField(
          label: 'Country',
          initialValue: countryId,
          isLoading: countries.isLoading,
          options: [
            for (final LocationOption c
                in countries.value ?? const <LocationOption>[])
              SelectOption(id: c.id, label: c.name),
          ],
          onSelected: onCountryChanged,
        ),
        const SizedBox(height: 12),
        SearchableSelectField(
          label: 'State',
          initialValue: stateId,
          enabled: countryId != null,
          isLoading: states?.isLoading ?? false,
          options: [
            for (final LocationOption s
                in states?.value ?? const <LocationOption>[])
              SelectOption(id: s.id, label: s.name),
          ],
          onSelected: onStateChanged,
        ),
        const SizedBox(height: 12),
        SearchableSelectField(
          label: 'District',
          initialValue: districtId,
          enabled: stateId != null,
          isLoading: districts?.isLoading ?? false,
          options: [
            for (final LocationOption d
                in districts?.value ?? const <LocationOption>[])
              SelectOption(id: d.id, label: d.name),
          ],
          onSelected: onDistrictChanged,
        ),
        const SizedBox(height: 12),
        SearchableSelectField(
          label: 'College / school',
          initialValue: orgId,
          enabled: districtId != null,
          isLoading: orgsAndDepartments?.isLoading ?? false,
          options: [
            for (final ReferenceOption o in orgsAndDepartments
                    ?.value
                    ?.organizations ??
                const <ReferenceOption>[])
              SelectOption(id: o.id, label: o.title),
          ],
          onSelected: onOrgChanged,
        ),
        const SizedBox(height: 12),
        SearchableSelectField(
          label: 'Department',
          initialValue: departmentId,
          enabled: districtId != null,
          isLoading: orgsAndDepartments?.isLoading ?? false,
          options: [
            for (final ReferenceOption d in orgsAndDepartments
                    ?.value
                    ?.departments ??
                const <ReferenceOption>[])
              SelectOption(id: d.id, label: d.title),
          ],
          onSelected: onDepartmentChanged,
        ),
      ],
    );
  }
}
