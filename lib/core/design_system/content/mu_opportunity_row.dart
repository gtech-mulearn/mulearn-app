import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/theme/mu_tones.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Jobs, internships and role calls as plain hairline rows (artifact
/// OpportunityRow): the organisation small and quiet, the role as the
/// title, the terms under it, the logo on the right. Put rows in a
/// [MuOpportunityGroup]. [status] (a pill: Applied, Closed) sits under the
/// terms; [closed] quiets the title.
class MuOpportunityRow extends StatelessWidget {
  /// One row.
  const MuOpportunityRow({
    required this.org,
    required this.role,
    this.terms,
    this.logoUrl,
    this.status,
    this.closed = false,
    this.divider = true,
    this.onTap,
    super.key,
  });

  /// "Career Lab · Hiring", the company name.
  final String org;

  /// "Frontend Intern".
  final String role;

  /// "Internship · Remote · Level 4+".
  final String? terms;

  /// The organisation's logo; a monogram on a category fill otherwise.
  final String? logoUrl;
  final Widget? status;
  final bool closed;
  final bool divider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final initial = org.trim().isEmpty ? '?' : org.trim().characters.first.toUpperCase();
    final monogram = Container(
      color: MuTones.forIgCategory(c, MuTones.hashed(org)),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: mu.text.title2.copyWith(fontSize: 18, fontWeight: FontWeight.w800, color: c.inkPrint),
      ),
    );

    final row = Container(
      padding: const EdgeInsets.symmetric(vertical: MuSpacing.space4),
      decoration: BoxDecoration(
        border: divider ? Border(bottom: BorderSide(color: c.line)) : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  org,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: mu.text.caption.copyWith(color: c.ink3),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: mu.text.title3.copyWith(fontSize: 16, color: closed ? c.ink3 : c.ink),
                ),
                if (terms != null && terms!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(terms!, maxLines: 2, overflow: TextOverflow.ellipsis, style: mu.text.caption),
                ],
                if (status != null) ...[const SizedBox(height: MuSpacing.space2), status!],
              ],
            ),
          ),
          const SizedBox(width: 14),
          ExcludeSemantics(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox.square(
                dimension: 44,
                child: logoUrl == null || logoUrl!.isEmpty
                    ? monogram
                    : CachedNetworkImage(
                        imageUrl: logoUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, _) => monogram,
                        errorWidget: (_, _, _) => monogram,
                      ),
              ),
            ),
          ),
        ],
      ),
    );

    return Semantics(
      container: true,
      button: onTap != null,
      label: [role, org, ?terms, if (closed) 'closed'].join(', '),
      child: onTap == null ? row : InkWell(onTap: onTap, child: row),
    );
  }
}

/// Opportunity rows on one `surface` card.
class MuOpportunityGroup extends StatelessWidget {
  /// A group of [children] rows (the last one without a divider).
  const MuOpportunityGroup({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space5, vertical: MuSpacing.space1),
      decoration: BoxDecoration(color: context.mu.colors.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
    );
  }
}
