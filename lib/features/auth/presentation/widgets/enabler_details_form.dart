import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/searchable_select_field.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';

/// Enabler role details — just a college pick with the "others" custom-entry
/// escape hatch, matching the reference's `enablerDetailsSchema` exactly (no
/// department/graduation-year/organization fields at all).
class EnablerDetailsForm extends ConsumerStatefulWidget {
  const EnablerDetailsForm({required this.onSubmitted, super.key});

  final VoidCallback onSubmitted;

  @override
  ConsumerState<EnablerDetailsForm> createState() => _EnablerDetailsFormState();
}

class _EnablerDetailsFormState extends ConsumerState<EnablerDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  String? _college;
  final _customCollegeController = TextEditingController();

  @override
  void dispose() {
    _customCollegeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();

    try {
      await ref.read(registerSubmitControllerProvider.notifier).submitGeneric(
            role: RegistrationRole.enabler,
            college: _college,
            customCollege: _college == kSearchableSelectOthersValue
                ? _customCollegeController.text.trim()
                : null,
          );
      widget.onSubmitted();
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar in the parent screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    final colleges = ref.watch(registerCollegesProvider);
    final isLoading = ref.watch(registerSubmitControllerProvider).isLoading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          colleges.when(
            data: (options) => SearchableSelectField(
              label: 'College',
              options:
                  options.map((o) => SelectOption(id: o.id, label: o.title)).toList(),
              allowOthers: true,
              enabled: !isLoading,
              initialValue: _college,
              onSelected: (value) => setState(() => _college = value),
              validator: (_) => _college == null || _college!.isEmpty
                  ? 'Please select your college.'
                  : null,
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
            const SizedBox(height: MuSpace.l),
            TextFormField(
              controller: _customCollegeController,
              enabled: !isLoading,
              decoration: const InputDecoration(labelText: 'College Name'),
              validator: (value) => (value?.trim().length ?? 0) < 3
                  ? 'College name must be at least 3 characters.'
                  : null,
            ),
          ],
          const SizedBox(height: MuSpace.xl),
          MuPrimaryButton(
            label: isLoading ? 'Submitting…' : 'Complete Registration',
            onPressed: isLoading ? null : _submit,
          ),
        ],
      ),
    );
  }
}

void _noop(String? _) {}
