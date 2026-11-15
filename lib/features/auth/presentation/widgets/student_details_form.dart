import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';

/// Learner details: a college (department, year of passing) or, for
/// company-employed learners, the company. Matches the dashboard's
/// `studentDetailsSchema`: college/department/year required on the College
/// side, organisation on the Company side, each with a "not listed" entry.
class StudentDetailsForm extends ConsumerStatefulWidget {
  const StudentDetailsForm({required this.onSubmitted, super.key});

  final VoidCallback onSubmitted;

  @override
  ConsumerState<StudentDetailsForm> createState() => _StudentDetailsFormState();
}

class _StudentDetailsFormState extends ConsumerState<StudentDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  OrganizationType _organizationType = OrganizationType.college;

  String? _college;
  final _customCollegeController = TextEditingController();
  String? _department;
  final _graduationYearController = TextEditingController();

  String? _organization;
  final _customOrganizationController = TextEditingController();

  @override
  void dispose() {
    _customCollegeController.dispose();
    _graduationYearController.dispose();
    _customOrganizationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();

    final isCollege = _organizationType == OrganizationType.college;
    final graduationYear = int.tryParse(_graduationYearController.text.trim());

    try {
      await ref
          .read(registerSubmitControllerProvider.notifier)
          .submitGeneric(
            role: RegistrationRole.student,
            college: isCollege ? _college : null,
            customCollege: isCollege && _college == muOtherOptionValue ? _customCollegeController.text.trim() : null,
            department: isCollege ? _department : null,
            graduationYear: isCollege ? graduationYear : null,
            organization: isCollege ? null : _organization,
            customOrganization: !isCollege && _organization == muOtherOptionValue
                ? _customOrganizationController.text.trim()
                : null,
            organizationType: _organizationType,
          );
      widget.onSubmitted();
    } on Object catch (_) {
      // Surfaced via the ref.listen toast in the parent screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    final colleges = ref.watch(registerCollegesProvider);
    final departments = ref.watch(registerDepartmentsProvider);
    final companies = ref.watch(registerCompaniesProvider);
    final loading = ref.watch(registerSubmitControllerProvider).isLoading;
    final isCollege = _organizationType == OrganizationType.college;

    List<MuOption> opts(List<ReferenceOption> list) => [for (final o in list) MuOption(o.id, o.title)];

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MuSegmented<OrganizationType>(
            values: const [OrganizationType.college, OrganizationType.company],
            selected: _organizationType,
            label: (t) => t == OrganizationType.college ? 'At a college' : 'At a company',
            onChanged: (t) {
              if (!loading) setState(() => _organizationType = t);
            },
          ),
          const SizedBox(height: MuSpacing.space5),
          if (isCollege) ...[
            MuSelectField(
              label: 'College',
              hint: 'Search your college',
              options: opts(colleges.value ?? const []),
              loading: colleges.isLoading,
              error: colleges.hasError ? "Couldn't load colleges. Go back and try again." : null,
              enabled: !loading,
              allowOther: true,
              otherLabel: 'My college is not listed',
              value: _college,
              onChanged: (v) => setState(() => _college = v),
              validator: (_) => (_college ?? '').isEmpty ? 'Pick your college to continue.' : null,
            ),
            if (_college == muOtherOptionValue) ...[
              const SizedBox(height: MuSpacing.space4),
              MuTextField(
                label: 'College name',
                controller: _customCollegeController,
                enabled: !loading,
                textCapitalization: TextCapitalization.words,
                validator: (v) => (v?.trim().length ?? 0) < 3 ? 'Use at least 3 characters.' : null,
              ),
            ],
            const SizedBox(height: MuSpacing.space4),
            MuSelectField(
              label: 'Department',
              options: opts(departments.value ?? const []),
              loading: departments.isLoading,
              error: departments.hasError ? "Couldn't load departments. Go back and try again." : null,
              enabled: !loading,
              value: _department,
              onChanged: (v) => setState(() => _department = v),
              validator: (_) => (_department ?? '').isEmpty ? 'Pick your department to continue.' : null,
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
                return (year == null || year < 2020 || year > 2040) ? 'Enter a year from 2020 to 2040.' : null;
              },
            ),
          ] else ...[
            MuSelectField(
              label: 'Company',
              hint: 'Search your company',
              options: opts(companies.value ?? const []),
              loading: companies.isLoading,
              error: companies.hasError ? "Couldn't load companies. Go back and try again." : null,
              enabled: !loading,
              allowOther: true,
              otherLabel: 'My company is not listed',
              value: _organization,
              onChanged: (v) => setState(() => _organization = v),
              validator: (_) => (_organization ?? '').isEmpty ? 'Pick your company to continue.' : null,
            ),
            if (_organization == muOtherOptionValue) ...[
              const SizedBox(height: MuSpacing.space4),
              MuTextField(
                label: 'Company name',
                controller: _customOrganizationController,
                enabled: !loading,
                textCapitalization: TextCapitalization.words,
                validator: (v) => (v?.trim().length ?? 0) < 3 ? 'Use at least 3 characters.' : null,
              ),
            ],
          ],
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
}
