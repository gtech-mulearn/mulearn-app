import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';

/// Enabler details, the dashboard's `enablerDetailsSchema`: just the
/// college, with a "not listed" entry.
class EnablerDetailsForm extends ConsumerStatefulWidget {
  const EnablerDetailsForm({required this.onSubmitted, super.key});

  final VoidCallback onSubmitted;

  @override
  ConsumerState<EnablerDetailsForm> createState() => _EnablerDetailsFormState();
}

class _EnablerDetailsFormState extends ConsumerState<EnablerDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  String? _college;
  String? _collegeName;
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
      await ref
          .read(registerSubmitControllerProvider.notifier)
          .submitGeneric(
            role: RegistrationRole.enabler,
            college: _college,
            customCollege: _college == muOtherOptionValue
                ? _customCollegeController.text.trim()
                : null,
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

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(registerSubmitControllerProvider).isLoading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            validator: (_) => (_college ?? '').isEmpty
                ? 'Pick your college to continue.'
                : null,
          ),
          if (_college == muOtherOptionValue) ...[
            const SizedBox(height: MuSpacing.space4),
            MuTextField(
              label: 'College name',
              controller: _customCollegeController,
              enabled: !loading,
              textCapitalization: TextCapitalization.words,
              validator: (v) => (v?.trim().length ?? 0) < 3
                  ? 'Use at least 3 characters.'
                  : null,
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
