import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/utils/unescape_literal_unicode.dart';

/// Markdown written on the dashboard (descriptions, briefs), in the design
/// system's type: body text in ink-2, links in cobalt that open in the
/// browser.
class MuMarkdown extends ConsumerWidget {
  const MuMarkdown(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final body = mu.text.body.copyWith(color: c.ink2, height: 1.55);
    return MarkdownBody(
      data: unescapeLiteralUnicode(text),
      onTapLink: (_, href, _) {
        final uri = href == null ? null : Uri.tryParse(href);
        if (uri != null) unawaited(ref.read(openExternalProvider)(uri));
      },
      styleSheet: MarkdownStyleSheet(
        p: body,
        h1: mu.text.title1,
        h2: mu.text.title2,
        h3: mu.text.title3,
        strong: body.copyWith(color: c.ink, fontWeight: FontWeight.w700),
        em: body.copyWith(fontStyle: FontStyle.italic),
        a: body.copyWith(color: c.cobaltText, decoration: TextDecoration.underline),
        listBullet: body,
        blockquote: body.copyWith(color: c.ink3),
        blockquoteDecoration: BoxDecoration(
          color: c.surfaceSunk,
          borderRadius: BorderRadius.circular(MuRadii.tag),
          border: Border(left: BorderSide(color: c.cobalt, width: 3)),
        ),
        blockquotePadding: const EdgeInsets.all(MuSpacing.space3),
        code: mu.text.codeSm.copyWith(color: c.ink, backgroundColor: c.surfaceSunk),
      ),
    );
  }
}
