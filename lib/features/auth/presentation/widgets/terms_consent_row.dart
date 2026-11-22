import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/config/app_links.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/utils/external_links.dart';

/// "I agree to the Terms and Privacy Policy" with both documents linked, shown
/// on sign-up. Tapping the box or the plain words toggles it; tapping a
/// document name opens it. [error] shows under the row when the user tried to
/// continue without agreeing.
class TermsConsentRow extends ConsumerStatefulWidget {
  /// A consent row bound to [value].
  const TermsConsentRow({
    required this.value,
    required this.onChanged,
    this.error,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? error;

  @override
  ConsumerState<TermsConsentRow> createState() => _TermsConsentRowState();
}

class _TermsConsentRowState extends ConsumerState<TermsConsentRow> {
  late final TapGestureRecognizer _terms = TapGestureRecognizer()
    ..onTap = () => unawaited(ref.read(openExternalProvider)(AppLinks.terms));
  late final TapGestureRecognizer _privacy = TapGestureRecognizer()
    ..onTap = () =>
        unawaited(ref.read(openExternalProvider)(AppLinks.privacyPolicy));

  @override
  void dispose() {
    _terms.dispose();
    _privacy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final base = mu.text.body.copyWith(color: c.ink2);
    final link = mu.text.bodyStrong.copyWith(
      color: c.cobaltText,
      decoration: TextDecoration.underline,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          container: true,
          checked: widget.value,
          label: 'I agree to the Terms and Conditions and the Privacy Policy',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => widget.onChanged(!widget.value),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    13,
                    MuSpacing.space3,
                    13,
                  ),
                  child: MuCheckbox(value: widget.value),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text.rich(
                    TextSpan(
                      style: base,
                      children: [
                        const TextSpan(text: 'I agree to the '),
                        TextSpan(
                          text: 'Terms',
                          style: link,
                          recognizer: _terms,
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: link,
                          recognizer: _privacy,
                        ),
                        const TextSpan(
                          text:
                              ', including that I will not post abusive or '
                              'objectionable content.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(top: MuSpacing.space1),
            child: Text(
              widget.error!,
              style: mu.text.caption.copyWith(color: c.danger),
            ),
          ),
      ],
    );
  }
}
