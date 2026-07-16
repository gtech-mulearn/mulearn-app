import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/widgets/searchable_select_field.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';

/// Mentor role details, matching the reference's `mentorDetailsSchema`
/// exactly: `organizationType` defaults to `"Company"` (opposite of the
/// student form's default), `organization` is always required regardless of
/// type, and department/graduation-year only apply — and only render — when
/// `organizationType == "College"`.
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
    final graduationYear =
        isCollege ? int.tryParse(_graduationYearController.text.trim()) : null;

    try {
      await ref.read(registerSubmitControllerProvider.notifier).submitGeneric(
            role: RegistrationRole.mentor,
            organization: _organization,
            customOrganization:
                _organization == kSearchableSelectOthersValue
                    ? _customOrganizationController.text.trim()
                    : null,
            department: isCollege ? _department : null,
            graduationYear: graduationYear,
            organizationType: _organizationType,
          );
      widget.onSubmitted();
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar in the parent screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCollege = _organizationType == OrganizationType.college;
    final options = isCollege
        ? ref.watch(registerCollegesProvider)
        : ref.watch(registerCompaniesProvider);
    final departments = ref.watch(registerDepartmentsProvider);
    final isLoading = ref.watch(registerSubmitControllerProvider).isLoading;
    final orgLabel = isCollege ? 'College' : 'Organization';

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
                : (selection) => setState(() {
                      _organizationType = selection.first;
                      _organization = null;
                    }),
          ),
          const SizedBox(height: 16),
          options.when(
            data: (opts) => SearchableSelectField(
              label: orgLabel,
              options: opts.map((o) => SelectOption(id: o.id, label: o.title)).toList(),
              allowOthers: true,
              enabled: !isLoading,
              initialValue: _organization,
              onSelected: (value) => setState(() => _organization = value),
              validator: (_) => _organization == null || _organization!.isEmpty
                  ? 'Please select your $orgLabel.'
                  : null,
            ),
            loading: () => SearchableSelectField(
              label: orgLabel,
              options: const [],
              isLoading: true,
              onSelected: _noop,
            ),
            error: (_, _) => SearchableSelectField(
              label: orgLabel,
              options: const [],
              hintText: 'Failed to load — pull to retry',
              onSelected: _noop,
            ),
          ),
          if (_organization == kSearchableSelectOthersValue) ...[
            const SizedBox(height: 16),
            TextFormField(
              controller: _customOrganizationController,
              enabled: !isLoading,
              decoration: InputDecoration(labelText: '$orgLabel Name'),
              validator: (value) => (value?.trim().length ?? 0) < 3
                  ? '$orgLabel name must be at least 3 characters.'
                  : null,
            ),
          ],
          if (isCollege) ...[
            const SizedBox(height: 16),
            departments.when(
              data: (opts) => SearchableSelectField(
                label: 'Department',
                options: opts.map((o) => SelectOption(id: o.id, label: o.title)).toList(),
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
                  return 'Year must be between 2020 and 2040.';
                }
                return null;
              },
            ),
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
