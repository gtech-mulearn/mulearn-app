import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/theme/mu_tones.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// A person: their photo, or their initials on an Interest Group colour
/// chosen by a stable hash of [name] (so the same person always gets the
/// same colour).
class MuAvatar extends StatelessWidget {
  /// An avatar of [size] (28 stacks, 40 rows, 88 profiles).
  const MuAvatar({
    required this.name,
    this.url,
    this.size = MuSizes.avatarSm,
    this.ring = true,
    super.key,
  });

  /// Full name; initials come from the first two words.
  final String name;

  /// Photo URL; null or failing falls back to initials.
  final String? url;

  /// Diameter.
  final double size;

  /// A 2dp ring in the surface colour (for stacks over other avatars).
  final bool ring;

  /// "Aysha Rahman" → "AR", "nikhil" → "N".
  static String initialsOf(String name) {
    final words = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return '';
    final first = words.first.characters.first;
    final second = words.length > 1 ? words[1].characters.first : '';
    return (first + second).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final fill = MuTones.forIgCategory(c, MuTones.hashed(name));
    final initials = Center(
      child: Text(
        initialsOf(name),
        style: mu.text.label.copyWith(
          color: c.inkPrint,
          fontSize: size * 0.36,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
    final photo = url == null || url!.isEmpty
        ? initials
        : CachedNetworkImage(
            imageUrl: url!,
            fit: BoxFit.cover,
            width: size,
            height: size,
            placeholder: (_, _) => initials,
            errorWidget: (_, _, _) => initials,
          );
    return Semantics(
      image: true,
      label: name,
      excludeSemantics: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: fill,
          shape: BoxShape.circle,
          border: ring ? Border.all(color: c.surface, width: 2) : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: photo,
      ),
    );
  }
}
