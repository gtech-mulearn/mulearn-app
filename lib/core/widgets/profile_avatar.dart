import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';

/// A circular profile photo with an initial-letter placeholder — shared by
/// the profile header and anywhere else an avatar is shown.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    required this.url,
    required this.name,
    super.key,
    this.size = 64,
  });

  final String? url;
  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final initial = name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : 'μ';
    final placeholder = Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        gradient: MulearnGradients.trusty,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.42,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    if (url == null || url!.isEmpty) return placeholder;

    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url!,
        height: size,
        width: size,
        fit: BoxFit.cover,
        placeholder: (_, __) => placeholder,
        errorWidget: (_, __, ___) => placeholder,
      ),
    );
  }
}
