import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/foundation/mu_avatar.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Up to three faces overlapping, then a `night` "+N" disc.
class MuAvatarStack extends StatelessWidget {
  /// Faces for [names] (photos from [urls] by index); [extraCount] people
  /// beyond them become "+N".
  const MuAvatarStack({
    required this.names,
    this.urls = const [],
    this.extraCount = 0,
    this.size = MuSizes.avatarSm,
    super.key,
  });

  /// People shown, in order (same campus first, then same IG).
  final List<String> names;

  /// Photo URLs by index.
  final List<String?> urls;

  /// People not shown.
  final int extraCount;

  /// Face diameter.
  final double size;

  static const _maxFaces = 3;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final faces = names.take(_maxFaces).toList();
    final more = extraCount + (names.length - faces.length);
    final step = size - 8;
    final count = faces.length + (more > 0 ? 1 : 0);
    if (count == 0) return const SizedBox.shrink();
    return Semantics(
      label: '${names.length + extraCount} people',
      excludeSemantics: true,
      child: SizedBox(
        width: (count - 1) * step + size,
        height: size,
        child: Stack(
          children: [
            for (var i = 0; i < faces.length; i++)
              Positioned(
                left: i * step,
                child: MuAvatar(
                  name: faces[i],
                  url: i < urls.length ? urls[i] : null,
                  size: size,
                ),
              ),
            if (more > 0)
              Positioned(
                left: faces.length * step,
                child: Container(
                  width: size,
                  height: size,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: c.night,
                    shape: BoxShape.circle,
                    border: Border.all(color: c.surface, width: 2),
                  ),
                  child: Text(
                    '+${more > 99 ? 99 : more}',
                    style: mu.text.codeSm.copyWith(
                      color: c.onNight,
                      fontSize: size * 0.34,
                      height: 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// An avatar stack followed by a sentence that names the first two people:
/// "Arjun, Sneha & 9 others from CET". Naming beats a bare "+11".
class MuPeerLine extends StatelessWidget {
  /// [names] are the people we can name; [total] is everyone counted.
  const MuPeerLine({
    required this.names,
    required this.total,
    this.urls = const [],
    this.scope,
    super.key,
  });

  /// Named people, in display order.
  final List<String> names;

  /// Everyone counted (≥ names.length).
  final int total;

  /// Photo URLs by index.
  final List<String?> urls;

  /// Where they're from ("from CET"), appended.
  final String? scope;

  /// The sentence alone, for semantics and tests.
  static String sentence(List<String> names, int total, {String? scope}) {
    String first(String n) => n.trim().split(RegExp(r'\s+')).first;
    final shown = names.take(2).map(first).toList();
    final others = total - shown.length;
    final String who;
    if (shown.isEmpty) {
      who = total == 1 ? '1 person' : '$total people';
    } else if (others <= 0) {
      who = shown.join(' and ');
    } else {
      who = '${shown.join(', ')} & $others ${others == 1 ? 'other' : 'others'}';
    }
    return scope == null ? who : '$who $scope';
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final text = sentence(names, total, scope: scope);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MuAvatarStack(
          names: names,
          urls: urls,
          extraCount: total - names.length.clamp(0, total),
        ),
        const SizedBox(width: MuSpacing.space2),
        Flexible(
          child: Text(
            text,
            style: mu.text.label.copyWith(
              color: mu.colors.ink2,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
