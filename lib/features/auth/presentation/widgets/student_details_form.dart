import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';

/// Where a learner learns, matching the dashboard's learner step
/// (`register-role-details.tsx`, 2026-11-23): School, College, Company or
/// Community, and "I'm not a student", which leaves Company and Community.
/// College asks for the department and year of passing; School asks for the
/// district first. Every list has a "not listed" entry.
class StudentDetailsForm extends ConsumerStatefulWidget {
  const StudentDetailsForm({
    required this.onSubmitted,
    this.onStudyingChanged,
    super.key,
  });

  final VoidCallback onSubmitted;

  /// Told when "I'm not a student" flips (true = studying).
  final ValueChanged<bool>? onStudyingChanged;

  @override
  ConsumerState<StudentDetailsForm> createState() => _StudentDetailsFormState();
}

const _studyingTypes = [
  OrganizationType.school,
  OrganizationType.college,
  OrganizationType.company,
  OrganizationType.community,
];

/// School and College imply studying.
const _workingTypes = [OrganizationType.company, OrganizationType.community];

extension on OrganizationType {
  String get label => switch (this) {
    OrganizationType.school => 'School',
    OrganizationType.college => 'College',
    OrganizationType.company => 'Company',
    OrganizationType.community => 'Community',
  };

  IconData get icon => switch (this) {
    OrganizationType.school => LucideIcons.school,
    OrganizationType.college => LucideIcons.graduationCap,
    OrganizationType.company => LucideIcons.briefcase,
    OrganizationType.community => LucideIcons.users,
  };
}

class _StudentDetailsFormState extends ConsumerState<StudentDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  bool _notStudent = false;
  OrganizationType _type = OrganizationType.college;

  String? _college;
  String? _collegeName;
  final _customCollegeController = TextEditingController();
  String? _department;
  final _graduationYearController = TextEditingController();

  /// The School, Company or Community picked (or [muOtherOptionValue]).
  String? _organization;
  final _customOrganizationController = TextEditingController();

  /// School only: the district its list comes from.
  String? _district;
  String? _districtName;

  @override
  void dispose() {
    _customCollegeController.dispose();
    _graduationYearController.dispose();
    _customOrganizationController.dispose();
    super.dispose();
  }

  /// A new type starts empty, so a company id is never sent as a community.
  void _setType(OrganizationType type) => setState(() {
    _type = type;
    _organization = null;
    _customOrganizationController.clear();
    _district = null;
    _districtName = null;
  });

  void _setNotStudent(bool notStudent) {
    setState(() => _notStudent = notStudent);
    if (notStudent && !_workingTypes.contains(_type)) {
      _setType(OrganizationType.company);
    }
    widget.onStudyingChanged?.call(!notStudent);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();

    final isCollege = _type == OrganizationType.college;
    final graduationYear = int.tryParse(_graduationYearController.text.trim());

    try {
      await ref
          .read(registerSubmitControllerProvider.notifier)
          .submitGeneric(
            role: RegistrationRole.student,
            college: isCollege ? _college : null,
            customCollege: isCollege && _college == muOtherOptionValue
                ? _customCollegeController.text.trim()
                : null,
            department: isCollege ? _department : null,
            graduationYear: isCollege ? graduationYear : null,
            organization: isCollege ? null : _organization,
            customOrganization:
                !isCollege && _organization == muOtherOptionValue
                ? _customOrganizationController.text.trim()
                : null,
            organizationType: _type,
            isStudent: !_notStudent,
          );
      widget.onSubmitted();
    } on Object catch (_) {
      // Surfaced via the ref.listen toast in the parent screen.
    }
  }

  /// Colleges matching [query] from the server (up to 20). There are
  /// thousands, so none is downloaded in full.
  Future<List<MuOption>> _searchColleges(String query) async => [
    for (final o
        in await ref.read(registerRepositoryProvider).searchColleges(query))
      MuOption(o.id, o.title),
  ];

  Future<List<MuOption>> _searchDistricts(String query) async => [
    for (final o
        in await ref.read(registerRepositoryProvider).searchDistricts(query))
      MuOption(o.id, o.title),
  ];

  List<MuOption> _opts(List<ReferenceOption> list) => [
    for (final o in list) MuOption(o.id, o.title),
  ];

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(registerSubmitControllerProvider).isLoading;
    final types = _notStudent ? _workingTypes : _studyingTypes;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MuSwitchTile(
            label: "I'm not a student",
            subtitle: 'Working, or learning outside school and college',
            value: _notStudent,
            onChanged: loading ? null : _setNotStudent,
          ),
          const SizedBox(height: MuSpacing.space5),
          Text('I learn at', style: context.mu.text.label),
          const SizedBox(height: MuSpacing.space2),
          for (var i = 0; i < types.length; i += 2) ...[
            if (i > 0) const SizedBox(height: 10),
            Row(
              children: [
                for (var j = i; j < i + 2; j++) ...[
                  if (j > i) const SizedBox(width: 10),
                  Expanded(
                    child: j < types.length
                        ? MuChoiceTile<OrganizationType>(
                            value: types[j],
                            groupValue: _type,
                            title: types[j].label,
                            icon: types[j].icon,
                            onChanged: loading ? null : _setType,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ],
          const SizedBox(height: MuSpacing.space5),
          if (_type == OrganizationType.college)
            ..._collegeFields(loading)
          else
            ..._organizationFields(loading),
          const SizedBox(height: MuSpacing.space6),
          MuButton(
            label: 'Finish sign-up',
            block: true,
            knob: true,
            loading: loading,
            loadingLabel: 'Creating your account…',
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  List<Widget> _collegeFields(bool loading) {
    final departments = ref.watch(registerDepartmentsProvider);
    return [
      MuSelectField(
        label: 'College',
        hint: 'Search your college',
        options: const [],
        search: _searchColleges,
        selectedLabel: _collegeName,
        onPicked: (o) => setState(() => _collegeName = o.label),
        enabled: !loading,
        allowOther: true,
        otherLabel: 'My college is not listed',
        value: _college,
        onChanged: (v) => setState(() => _college = v),
        validator: (_) =>
            (_college ?? '').isEmpty ? 'Pick your college to continue.' : null,
      ),
      if (_college == muOtherOptionValue) ...[
        const SizedBox(height: MuSpacing.space4),
        MuTextField(
          label: 'College name',
          controller: _customCollegeController,
          enabled: !loading,
          textCapitalization: TextCapitalization.words,
          validator: (v) =>
              (v?.trim().length ?? 0) < 3 ? 'Use at least 3 characters.' : null,
        ),
      ],
      const SizedBox(height: MuSpacing.space4),
      MuSelectField(
        label: 'Department',
        options: _opts(departments.value ?? const []),
        loading: departments.isLoading,
        error: departments.hasError
            ? "Couldn't load departments. Go back and try again."
            : null,
        enabled: !loading,
        value: _department,
        onChanged: (v) => setState(() => _department = v),
        validator: (_) => (_department ?? '').isEmpty
            ? 'Pick your department to continue.'
            : null,
      ),
      const SizedBox(height: MuSpacing.space4),
      MuTextField(
        label: 'Year of passing',
        hint: 'e.g. 2027',
        controller: _graduationYearController,
        enabled: !loading,
        keyboardType: TextInputType.number,
        maxLength: 4,
        validator: (value) {
          final year = int.tryParse(value?.trim() ?? '');
          return (year == null || year < 2020 || year > 2040)
              ? 'Enter a year from 2020 to 2040.'
              : null;
        },
      ),
    ];
  }

  /// School (after its district), Company or Community, and the name field
  /// when it isn't listed.
  List<Widget> _organizationFields(bool loading) {
    final notListed = _organization == muOtherOptionValue;
    final name = _type.label;
    final lower = name.toLowerCase();

    final list = switch (_type) {
      OrganizationType.school =>
        _district == null
            ? null
            : ref.watch(registerSchoolsProvider(_district!)),
      OrganizationType.company => ref.watch(registerCompaniesProvider),
      OrganizationType.community => ref.watch(registerCommunitiesProvider),
      OrganizationType.college => null,
    };
    final hint = switch (_type) {
      OrganizationType.school =>
        _district == null ? 'Pick your district first' : 'Select your school',
      OrganizationType.company => 'Search your company',
      _ => 'Select your community',
    };
    final error = switch (_type) {
      OrganizationType.school =>
        "Couldn't load schools. Pick the district again.",
      _ =>
        "Couldn't load ${lower == 'company' ? 'companies' : 'communities'}. "
            'Go back and try again.',
    };

    return [
      if (_type == OrganizationType.school && !notListed) ...[
        MuSelectField(
          key: const ValueKey('district'),
          label: 'District',
          hint: 'Search your district',
          options: const [],
          search: _searchDistricts,
          selectedLabel: _districtName,
          onPicked: (o) => setState(() => _districtName = o.label),
          enabled: !loading,
          value: _district,
          onChanged: (v) => setState(() {
            _district = v;
            _organization = null;
          }),
          validator: (_) => (_district ?? '').isEmpty
              ? 'Pick your district to continue.'
              : null,
        ),
        const SizedBox(height: MuSpacing.space4),
      ],
      MuSelectField(
        // A new type or district is a new field: nothing carries over.
        key: ValueKey('org-${_type.name}-$_district'),
        label: name,
        hint: hint,
        options: _opts(list?.value ?? const []),
        loading: list?.isLoading ?? false,
        error: (list?.hasError ?? false) ? error : null,
        enabled: !loading,
        allowOther: true,
        otherLabel: 'My $lower is not listed',
        value: _organization,
        onChanged: (v) => setState(() => _organization = v),
        validator: (_) => (_organization ?? '').isEmpty
            ? 'Pick your $lower to continue.'
            : null,
      ),
      if (notListed) ...[
        const SizedBox(height: MuSpacing.space4),
        MuTextField(
          label: '$name name',
          controller: _customOrganizationController,
          enabled: !loading,
          textCapitalization: TextCapitalization.words,
          validator: (v) =>
              (v?.trim().length ?? 0) < 3 ? 'Use at least 3 characters.' : null,
        ),
      ],
    ];
  }
}
