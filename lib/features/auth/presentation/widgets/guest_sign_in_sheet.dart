import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/auth/domain/entities/social_sign_in_outcome.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';

/// Sign-in as a continuation (artifact Pre-login → Sign-in as a
/// continuation): a guest who tries to act gets this sheet, titled with what
/// they were doing ("Sign in to join Ui Ux"). After signing in they land on
/// [resumeTo], where the action is one tap away; Not now loses nothing.
Future<void> showGuestSignIn(BuildContext context, {String? action, String? resumeTo}) {
  return showMuSheet<void>(
    context,
    builder: (_) => _GuestSignInSheet(action: action, resumeTo: resumeTo),
  );
}

class _GuestSignInSheet extends ConsumerStatefulWidget {
  const _GuestSignInSheet({required this.action, required this.resumeTo});

  final String? action;
  final String? resumeTo;

  @override
  ConsumerState<_GuestSignInSheet> createState() => _GuestSignInSheetState();
}

class _GuestSignInSheetState extends ConsumerState<_GuestSignInSheet> {
  bool _busy = false;

  String get _from => widget.resumeTo == null ? '' : '?from=${Uri.encodeQueryComponent(widget.resumeTo!)}';

  Future<void> _google() async {
    final router = GoRouter.of(context);
    final nav = Navigator.of(context);
    setState(() => _busy = true);
    try {
      final outcome = await ref.read(authControllerProvider.notifier).signInWithGoogle();
      if (!mounted) return;
      nav.pop();
      if (outcome is SocialNeedsRegistration) {
        ref
            .read(registerWizardControllerProvider.notifier)
            .setGoogleSignUp(tempToken: outcome.tempToken, email: outcome.email, fullName: outcome.fullName);
        await router.push(RoutePaths.registerBasicInfo);
      } else if (widget.resumeTo != null) {
        router.go(widget.resumeTo!);
      }
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  Future<void> _apple() async {
    final router = GoRouter.of(context);
    final nav = Navigator.of(context);
    setState(() => _busy = true);
    try {
      await ref.read(authControllerProvider.notifier).signInWithApple();
      if (!mounted) return;
      nav.pop();
      if (widget.resumeTo != null) router.go(widget.resumeTo!);
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final router = GoRouter.of(context);
    final isApple = defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS;

    return Padding(
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 0, MuSpacing.space5, MuSpacing.space5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('ONE STEP', style: mu.text.eyebrow.copyWith(color: c.ink3)),
          const SizedBox(height: 6),
          Semantics(
            header: true,
            child: Text(widget.action == null ? 'Sign in' : 'Sign in to ${widget.action}', style: mu.text.title1),
          ),
          const SizedBox(height: MuSpacing.space2),
          Text(
            "We'll bring you right back here and finish what you started.",
            style: mu.text.body.copyWith(color: c.ink2),
          ),
          const SizedBox(height: MuSpacing.space5),
          MuButton(
            label: 'Continue with Google',
            icon: LucideIcons.chrome,
            variant: MuButtonVariant.ink,
            block: true,
            loading: _busy,
            onPressed: _busy ? null : _google,
          ),
          if (isApple) ...[
            const SizedBox(height: MuSpacing.space3),
            MuButton(
              label: 'Continue with Apple',
              icon: LucideIcons.apple,
              variant: MuButtonVariant.outline,
              block: true,
              onPressed: _busy ? null : _apple,
            ),
          ],
          const SizedBox(height: MuSpacing.space3),
          MuButton(
            label: 'Use email or muid',
            icon: LucideIcons.mail,
            variant: MuButtonVariant.outline,
            block: true,
            onPressed: _busy
                ? null
                : () {
                    Navigator.of(context).pop();
                    router.push('${RoutePaths.signIn}$_from');
                  },
          ),
          const SizedBox(height: MuSpacing.space2),
          // Wraps under large text instead of overflowing.
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('New to μLearn?', style: mu.text.body.copyWith(color: c.ink2)),
              MuButton(
                label: 'Create an account',
                variant: MuButtonVariant.ghost,
                size: MuButtonSize.small,
                onPressed: _busy
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        router.push(RoutePaths.registerBasicInfo);
                      },
              ),
            ],
          ),
          MuButton(label: 'Not now', variant: MuButtonVariant.ghost, onPressed: () => Navigator.of(context).pop()),
        ],
      ),
    );
  }
}
