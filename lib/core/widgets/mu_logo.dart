import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

enum _LogoKind { mark, wordmark, wordmarkOnBrand }

/// The μLearn logo — the dashboard's own images, never a typed μ glyph:
/// - [MuLogo.mark]: the gradient μ (the dashboard favicon), optionally on a
///   white rounded [tile] like the app icon;
/// - [MuLogo.wordmark]: "μLearn — a GTech Initiative" (`public/logo.webp`),
///   for light surfaces;
/// - [MuLogo.wordmarkOnBrand]: the wordmark in white for brand-coloured
///   surfaces (`public/logo-dark.webp`, recoloured).
/// Screen readers hear "μLearn".
class MuLogo extends StatelessWidget {
  const MuLogo.mark({double size = 48, this.tile = false, super.key})
      : _kind = _LogoKind.mark,
        _size = size;

  const MuLogo.wordmark({double height = 40, super.key})
      : _kind = _LogoKind.wordmark,
        _size = height,
        tile = false;

  const MuLogo.wordmarkOnBrand({double height = 28, super.key})
      : _kind = _LogoKind.wordmarkOnBrand,
        _size = height,
        tile = false;

  final _LogoKind _kind;
  final double _size;

  /// For [MuLogo.mark]: draw it on a white rounded square of [_size].
  final bool tile;

  static const markAsset = 'assets/images/logo.png';
  static const wordmarkAsset = 'assets/images/logo_wordmark.webp';
  static const wordmarkMonoAsset = 'assets/images/logo_wordmark_mono.webp';

  @override
  Widget build(BuildContext context) {
    final image = switch (_kind) {
      _LogoKind.mark when tile => Container(
          height: _size,
          width: _size,
          padding: EdgeInsets.all(_size * 0.2),
          decoration: BoxDecoration(
            color: MuColors.surface,
            borderRadius: BorderRadius.circular(_size * 0.28),
          ),
          child: Image.asset(markAsset, fit: BoxFit.contain),
        ),
      _LogoKind.mark => Image.asset(markAsset, height: _size, width: _size, fit: BoxFit.contain),
      _LogoKind.wordmark => Image.asset(wordmarkAsset, height: _size, fit: BoxFit.contain),
      _LogoKind.wordmarkOnBrand => ColorFiltered(
          colorFilter: const ColorFilter.mode(MuColors.onBrand, BlendMode.srcIn),
          child: Image.asset(wordmarkMonoAsset, height: _size, fit: BoxFit.contain),
        ),
    };
    return Semantics(label: 'μLearn', image: true, child: ExcludeSemantics(child: image));
  }
}
