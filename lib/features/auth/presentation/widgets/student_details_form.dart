import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/widgets/searchable_select_field.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';

/// Learner ("student") role details — college OR company-employed-student
/// branch, matching the reference's `studentDetailsSchema` exactly:
/// `organizationType` defaults to `"College"`, college/department/graduation
/// year required in that branch, organization required in the Company
/// branch, with an "others" custom-entry escape hatch on both.
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
      await ref.read(registerSubmitControllerProvider.notifier).submitGeneric(
            role: RegistrationRole.student,
            college: isCollege ? _college : null,
            customCollege:
                isCollege && _college == kSearchableSelectOthersValue
                    ? _customCollegeController.text.trim()
                    : null,
            department: isCollege ? _department : null,
            graduationYear: isCollege ? graduationYear : null,
            organization: isCollege ? null : _organization,
            customOrganization: !isCollege &&
                    _organization == kSearchableSelectOthersValue
                ? _customOrganizationController.text.trim()
                : null,
            organizationType: _organizationType,
          );
      widget.onSubmitted();
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar in the parent screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    final colleges = ref.watch(registerCollegesProvider);
    final departments = ref.watch(registerDepartmentsProvider);
    final companies = ref.watch(registerCompaniesProvider);
    final isLoading = ref.watch(registerSubmitControllerProvider).isLoading;
    final isCollege = _organizationType == OrganizationType.college;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedButton<OrganizationType>(
            segments: const [
              ButtonSegment(
                value: OrganizationType.college,
                label: Text('College'),
              ),
              ButtonSegment(
                value: OrganizationType.company,
                label: Text('Company'),
              ),
            ],
            selected: {_organizationType},
            onSelectionChanged: isLoading
                ? null
                : (selection) =>
                    setState(() => _organizationType = selection.first),
          ),
          const SizedBox(height: 16),
          if (isCollege) ...[
            colleges.when(
              data: (options) => SearchableSelectField(
                label: 'College',
                options:
                    options.map((o) => SelectOption(id: o.id, label: o.title)).toList(),
                allowOthers: true,
                enabled: !isLoading,
                initialValue: _college,
                onSelected: (value) => setState(() => _college = value),
                validator: (_) =>
                    _college == null || _college!.isEmpty ? 'Please select your college.' : null,
              ),
              loading: () => const SearchableSelectField(
                label: 'College',
                options: [],
                isLoading: true,
                onSelected: _noop,
              ),
              error: (_, _) => const SearchableSelectField(
                label: 'College',
                options: [],
                hintText: 'Failed to load — pull to retry',
                onSelected: _noop,
              ),
            ),
            if (_college == kSearchableSelectOthersValue) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _customCollegeController,
                enabled: !isLoading,
                decoration: const InputDecoration(labelText: 'College Name'),
                validator: (value) => (value?.trim().length ?? 0) < 3
                    ? 'College name must be at least 3 characters.'
                    : null,
              ),
            ],
            const SizedBox(height: 16),
            departments.when(
              data: (options) => SearchableSelectField(
                label: 'Department',
                options:
                    options.map((o) => SelectOption(id: o.id, label: o.title)).toList(),
                enabled: !isLoading,
                initialValue: _department,
                onSelected: (value) => setState(() => _department = value),
                validator: (_) => _department == null || _department!.isEmpty
                    ? 'Please select your department.'
                    : null,
              ),
              loading: () => const SearchableSelectField(
                label: 'Department',
                options: [],
                isLoading: true,
                onSelected: _noop,
              ),
              error: (_, _) => const SearchableSelectField(
                label: 'Department',
                options: [],
                hintText: 'Failed to load — pull to retry',
                onSelected: _noop,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _graduationYearController,
              enabled: !isLoading,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Year of Passing'),
              validator: (value) {
                final year = int.tryParse(value?.trim() ?? '');
                if (year == null || year < 2020 || year > 2040) {
                  return 'Year of pass must be between 2020 and 2040.';
                }
                return null;
              },
            ),
          ] else ...[
            companies.when(
              data: (options) => SearchableSelectField(
                label: 'Organization',
                options:
                    options.map((o) => SelectOption(id: o.id, label: o.title)).toList(),
                allowOthers: true,
                enabled: !isLoading,
                initialValue: _organization,
                onSelected: (value) => setState(() => _organization = value),
                validator: (_) => _organization == null || _organization!.isEmpty
                    ? 'Please select your organization.'
                    : null,
              ),
              loading: () => const SearchableSelectField(
                label: 'Organization',
                options: [],
                isLoading: true,
                onSelected: _noop,
              ),
              error: (_, _) => const SearchableSelectField(
                label: 'Organization',
                options: [],
                hintText: 'Failed to load — pull to retry',
                onSelected: _noop,
              ),
            ),
            if (_organization == kSearchableSelectOthersValue) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _customOrganizationController,
                enabled: !isLoading,
                decoration: const InputDecoration(labelText: 'Organization Name'),
                validator: (value) => (value?.trim().length ?? 0) < 3
                    ? 'Organization name must be at least 3 characters.'
                    : null,
              ),
            ],
          ],
          const SizedBox(height: 28),
          FilledButton(
            onPressed: isLoading ? null : _submit,
            child: isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                : const Text('Complete Registration'),
          ),
        ],
      ),
    );
  }
}

void _noop(String? _) {}
