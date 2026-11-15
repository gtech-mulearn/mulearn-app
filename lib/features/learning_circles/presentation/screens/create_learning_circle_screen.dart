import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/auth/current_user_college.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';

/// Start a circle: an interest group, a title and what it's for. The
/// campus isn't a picker: a circle lives at its creator's own college
/// ([currentUserCollegeProvider]), shown so it's clear where.
class CreateLearningCircleScreen extends ConsumerStatefulWidget {
  const CreateLearningCircleScreen({super.key});

  @override
  ConsumerState<CreateLearningCircleScreen> createState() =>
      _CreateLearningCircleScreenState();
}

class _CreateLearningCircleScreenState
    extends ConsumerState<CreateLearningCircleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  String? _igId;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _submit(String? orgId) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (orgId == null) {
      MuToast.show(
        context,
        message:
            'Your account has no college on file. Add it in Edit profile, then start a circle.',
        type: MuToastType.error,
      );
      return;
    }
    final circleId = await ref
        .read(circleActionsControllerProvider.notifier)
        .createCircle(
          igId: _igId!,
          orgId: orgId,
          title: _title.text.trim(),
          description: _description.text.trim(),
        );
    if (!mounted) return;
    if (circleId != null) {
      ref
        ..invalidate(circlesListControllerProvider)
        ..invalidate(myCirclesProvider);
      MuToast.show(
        context,
        message: 'Your circle is live',
        type: MuToastType.success,
      );
      context.pushReplacement(RoutePaths.learningCircleDetailPath(circleId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final igOptions = ref.watch(circleIgOptionsProvider);
    final college = ref.watch(currentUserCollegeProvider);
    final action = ref.watch(circleActionsControllerProvider);
    final orgId = college.value?.id;

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        child: Column(
          children: [
            const MuTopBar.detail(),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.fromLTRB(
                    MuSpacing.space5,
                    MuSpacing.space2,
                    MuSpacing.space5,
                    MuSpacing.space8,
                  ),
                  children: [
                    Semantics(
                      header: true,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Start a\n',
                              style: mu.text.displayLight.copyWith(
                                fontSize: 36,
                              ),
                            ),
                            TextSpan(
                              text: 'circle',
                              style: mu.text.display.copyWith(fontSize: 36),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: MuSpacing.space2),
                    Text(
                      'Pick a skill, bring a few friends, and meet every week.',
                      style: mu.text.body.copyWith(color: c.ink2),
                    ),
                    const SizedBox(height: MuSpacing.space6),
                    MuSelectField(
                      label: 'Interest group',
                      value: _igId,
                      loading: igOptions.isLoading,
                      options:
                          igOptions.value
                              ?.map((o) => MuOption(o.id, o.label))
                              .toList() ??
                          const [],
                      validator: (v) => v == null
                          ? 'Pick the group this circle learns in'
                          : null,
                      onChanged: (v) => setState(() => _igId = v),
                    ),
                    const SizedBox(height: MuSpacing.space4),
                    MuTextField(
                      label: 'Title',
                      controller: _title,
                      hint: 'Pandas Saturdays',
                      maxLength: 100,
                      textCapitalization: TextCapitalization.words,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Give it a name'
                          : null,
                    ),
                    const SizedBox(height: MuSpacing.space4),
                    MuTextField(
                      label: 'What you will learn',
                      controller: _description,
                      hint:
                          'We work through the Kaggle Pandas course, one lesson a week.',
                      maxLength: 500,
                      maxLines: 5,
                      minLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Say what the circle is for'
                          : null,
                    ),
                    const SizedBox(height: MuSpacing.space4),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.mapPin,
                          size: MuSizes.iconSm,
                          color: c.ink3,
                        ),
                        const SizedBox(width: MuSpacing.space2),
                        Expanded(
                          child: Text(
                            college.when(
                              loading: () => 'Finding your college…',
                              error: (_, _) =>
                                  "Couldn't load your college. Pull to try again.",
                              data: (col) => col.code != null
                                  ? 'Meets at your college (${col.code})'
                                  : 'Meets at your college',
                            ),
                            style: mu.text.caption.copyWith(
                              color: college.hasError ? c.danger : c.ink3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: c.chalk,
                border: Border(top: BorderSide(color: c.line)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space3,
                  MuSpacing.space5,
                  MuSpacing.space3,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (action.hasError) ...[
                      Text(
                        ApiException.messageFor(action.error!),
                        style: mu.text.caption.copyWith(color: c.danger),
                      ),
                      const SizedBox(height: MuSpacing.space2),
                    ],
                    MuButton(
                      label: 'Start circle',
                      variant: MuButtonVariant.ink,
                      knob: true,
                      block: true,
                      loading: action.isLoading,
                      onPressed: action.isLoading ? null : () => _submit(orgId),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
