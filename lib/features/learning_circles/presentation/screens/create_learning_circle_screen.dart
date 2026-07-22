import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/core/widgets/searchable_select_field.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';

/// Create-circle form — IG + org pickers, title, description.
class CreateLearningCircleScreen extends ConsumerStatefulWidget {
  const CreateLearningCircleScreen({super.key});

  @override
  ConsumerState<CreateLearningCircleScreen> createState() =>
      _CreateLearningCircleScreenState();
}

class _CreateLearningCircleScreenState
    extends ConsumerState<CreateLearningCircleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _igId;
  String? _orgId;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_igId == null || _orgId == null) {
      MuToast.show(
        context,
        message: 'Please select an interest group and college.',
        type: MuToastType.error,
      );
      return;
    }
    final circleId = await ref
        .read(circleActionsControllerProvider.notifier)
        .createCircle(
          igId: _igId!,
          orgId: _orgId!,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
        );
    if (!mounted) return;
    if (circleId != null) {
      ref
        ..invalidate(circlesListControllerProvider)
        ..invalidate(myCirclesProvider);
      context.pushReplacement(RoutePaths.learningCircleDetailPath(circleId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final igOptionsState = ref.watch(circleIgOptionsProvider);
    final orgOptionsState = ref.watch(circleOrgOptionsProvider);
    final actionState = ref.watch(circleActionsControllerProvider);

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(title: const Text('Create Learning Circle')),
      body: Padding(
        padding: const EdgeInsets.all(MuSpace.screenH),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SearchableSelectField(
                label: 'Interest group',
                options: igOptionsState.value ?? const [],
                isLoading: igOptionsState.isLoading,
                onSelected: (value) => setState(() => _igId = value),
              ),
              const SizedBox(height: MuSpace.l),
              SearchableSelectField(
                label: 'College',
                options: orgOptionsState.value ?? const [],
                isLoading: orgOptionsState.isLoading,
                onSelected: (value) => setState(() => _orgId = value),
              ),
              const SizedBox(height: MuSpace.l),
              TextFormField(
                controller: _titleController,
                maxLength: 100,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Title is required'
                    : null,
              ),
              TextFormField(
                controller: _descriptionController,
                maxLength: 500,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Description is required'
                    : null,
              ),
              if (actionState.hasError) ...[
                const SizedBox(height: MuSpace.s),
                Text(
                  ApiException.messageFor(actionState.error!),
                  style: MuType.caption.copyWith(color: MuColors.coral),
                ),
              ],
              const SizedBox(height: MuSpace.l),
              MuPrimaryButton(
                label: actionState.isLoading ? 'Creating…' : 'Create',
                onPressed: actionState.isLoading ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
