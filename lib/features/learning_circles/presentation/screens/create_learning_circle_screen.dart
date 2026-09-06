import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/auth/current_user_college.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/core/widgets/searchable_select_field.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';

/// Create-circle form — IG picker, title, description. The college is no
/// longer a picker: it defaults to the signed-in user's own college
/// ([currentUserCollegeProvider]) — a circle only ever makes sense at the
/// creator's own campus, so asking them to re-pick it from a 1000+ row list
/// was pure friction, not a real choice.
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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit(String? orgId) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_igId == null) {
      MuToast.show(
        context,
        message: 'Please select an interest group.',
        type: MuToastType.error,
      );
      return;
    }
    if (orgId == null) {
      MuToast.show(
        context,
        message:
            'Your account has no college on file — update your profile before creating a circle.',
        type: MuToastType.error,
      );
      return;
    }
    final circleId = await ref
        .read(circleActionsControllerProvider.notifier)
        .createCircle(
          igId: _igId!,
          orgId: orgId,
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
    final collegeState = ref.watch(currentUserCollegeProvider);
    final actionState = ref.watch(circleActionsControllerProvider);
    final orgId = collegeState.value?.id;

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(MuSpace.screenH),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Start a circle', style: MuType.display.copyWith(fontSize: 26)),
              const SizedBox(height: MuSpace.xs),
              Text(
                'Pick a skill, invite a few friends, and learn weekly.',
                style: MuType.body.copyWith(color: MuColors.inkSecondary),
              ),
              const SizedBox(height: MuSpace.xxl),
              SearchableSelectField(
                label: 'Interest group',
                options: igOptionsState.value ?? const [],
                isLoading: igOptionsState.isLoading,
                onSelected: (value) => setState(() => _igId = value),
              ),
              const SizedBox(height: MuSpace.s),
              collegeState.when(
                loading: () => Text(
                  'Loading your college…',
                  style: MuType.caption,
                ),
                error: (_, __) => Text(
                  "Couldn't load your college — try again.",
                  style: MuType.caption.copyWith(color: MuColors.error),
                ),
                data: (college) => Text(
                  college.code != null
                      ? 'Circle location: your college (${college.code})'
                      : 'Circle location: your college',
                  style: MuType.caption,
                ),
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
                  style: MuType.caption.copyWith(color: MuColors.error),
                ),
              ],
              const SizedBox(height: MuSpace.l),
              MuPrimaryButton(
                label: actionState.isLoading ? 'Creating…' : 'Create',
                onPressed: actionState.isLoading ? null : () => _submit(orgId),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
