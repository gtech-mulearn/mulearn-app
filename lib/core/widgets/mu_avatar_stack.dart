import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';

/// Overlapping avatar row with an optional "+N" trailing circle (rules.md
/// §8).
class MuAvatarStack extends StatelessWidget {
  const MuAvatarStack({
    required this.names,
    super.key,
    this.urls = const [],
    this.extraCount = 0,
    this.size = 28,
  });

  final List<String> names;
  final List<String?> urls;
  final int extraCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    final overlap = size * 0.3;
    final itemCount = names.length + (extraCount > 0 ? 1 : 0);
    // The Stack below has only Positioned children, so with no explicit
    // width it collapses to zero / unbounded width depending on the parent
    // — Flutter then can't hit-test it ("Cannot hit test a render box with
    // no size"). Compute the actual rightmost extent from the same overlap
    // math the Positioned offsets use.
    final width = itemCount == 0 ? 0.0 : (itemCount - 1) * (size - overlap) + size;
    return SizedBox(
      height: size,
      width: width,
      child: Stack(
        children: [
          for (var i = 0; i < names.length; i++)
            Positioned(
              left: i * (size - overlap),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: MuColors.surface, width: 2),
                ),
                child: ProfileAvatar(
                  url: i < urls.length ? urls[i] : null,
                  name: names[i],
                  size: size,
                ),
              ),
            ),
          if (extraCount > 0)
            Positioned(
              left: names.length * (size - overlap),
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: MuColors.karmaAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: MuColors.surface, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+$extraCount',
                  style: MuType.statSmall.copyWith(
                    color: MuColors.surface,
                    fontSize: size * 0.32,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
