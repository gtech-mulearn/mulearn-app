import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';

/// Mentor details, the dashboard's `mentorDetailsSchema`: the organisation
/// type starts at Company (the student form starts at College), the
/// organisation is always required, and department and year of passing
/// appear only for a college.
class MentorDetailsForm extends ConsumerStatefulWidget {
  const MentorDetailsForm({required this.onSubmitted, super.key});

  final VoidCallback onSubmitted;

  @override
  ConsumerState<MentorDetailsForm> createState() => _MentorDetailsFormState();
}

class _MentorDetailsFormState extends ConsumerState<MentorDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  OrganizationType _organizationType = OrganizationType.company;

  String? _organization;
  final _customOrganizationController = TextEditingController();
  String? _department;
  final _graduationYearController = TextEditingController();

  @override
  void dispose() {
    _customOrganizationController.dispose();
    _graduationYearController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();

    final isCollege = _organizationType == OrganizationType.college;
    final graduationYear = isCollege ? int.tryParse(_graduationYearController.text.trim()) : null;

    try {
      await ref
          .read(registerSubmitControllerProvider.notifier)
          .submitGeneric(
            role: RegistrationRole.mentor,
            organization: _organization,
            customOrganization: _organization == muOtherOptionValue ? _customOrganizationController.text.trim() : null,
            department: isCollege ? _department : null,
            graduationYear: graduationYear,
            organizationType: _organizationType,
          );
      widget.onSubmitted();
    } on Object catch (_) {
      // Surfaced via the ref.listen toast in the parent screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCollege = _organizationType == OrganizationType.college;
    final options = isCollege ? ref.watch(registerCollegesProvider) : ref.watch(registerCompaniesProvider);
    final departments = ref.watch(registerDepartmentsProvider);
    final loading = ref.watch(registerSubmitControllerProvider).isLoading;
    final orgLabel = isCollege ? 'College' : 'Company';

    List<MuOption> opts(List<ReferenceOption> list) => [for (final o in list) MuOption(o.id, o.title)];

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MuSegmented<OrganizationType>(
            values: const [OrganizationType.company, OrganizationType.college],
            selected: _organizationType,
            label: (t) => t == OrganizationType.college ? 'At a college' : 'At a company',
            onChanged: (t) {
              if (loading) return;
              setState(() {
                _organizationType = t;
                _organization = null;
              });
            },
          ),
          const SizedBox(height: MuSpacing.space5),
          MuSelectField(
            label: orgLabel,
            hint: 'Search your ${orgLabel.toLowerCase()}',
            options: opts(options.value ?? const []),
            loading: options.isLoading,
            error: options.hasError ? "Couldn't load the list. Go back and try again." : null,
            enabled: !loading,
            allowOther: true,
            otherLabel: 'My ${orgLabel.toLowerCase()} is not listed',
            value: _organization,
            onChanged: (v) => setState(() => _organization = v),
            validator: (_) => (_organization ?? '').isEmpty ? 'Pick your ${orgLabel.toLowerCase()} to continue.' : null,
          ),
          if (_organization == muOtherOptionValue) ...[
            const SizedBox(height: MuSpacing.space4),
            MuTextField(
              label: '$orgLabel name',
              controller: _customOrganizationController,
              enabled: !loading,
              textCapitalization: TextCapitalization.words,
              validator: (v) => (v?.trim().length ?? 0) < 3 ? 'Use at least 3 characters.' : null,
            ),
          ],
          if (isCollege) ...[
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
