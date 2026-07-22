import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/core/widgets/mu_stat_block.dart';

/// μLearn ID card (rules.md §8) — stat blocks + a QR-shaped placeholder.
/// This app doesn't currently generate a scannable QR image; the bordered
/// box is a deliberate placeholder for where one would render.
class MuQrCard extends StatelessWidget {
  const MuQrCard({
    required this.muid,
    super.key,
    this.college,
    this.district,
    this.onShare,
    this.onCopy,
  });

  final String muid;
  final String? college;
  final String? district;
  final VoidCallback? onShare;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    return MuCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('μLearn ID', style: MuType.title)),
              if (onCopy != null) ...[
                MuIconButton(icon: LucideIcons.copy, onPressed: onCopy),
                const SizedBox(width: MuSpace.s),
              ],
              if (onShare != null)
                MuIconButton(icon: LucideIcons.share2, onPressed: onShare),
            ],
          ),
          const SizedBox(height: MuSpace.l),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MuStatBlock(label: 'MUID', value: muid, valueStyle: MuType.statSmall),
                    if (college != null) ...[
                      const SizedBox(height: MuSpace.m),
                      MuStatBlock(
                        label: 'College',
                        value: college!,
                        valueStyle: MuType.bodyMed,
                      ),
                    ],
                    if (district != null) ...[
                      const SizedBox(height: MuSpace.m),
                      MuStatBlock(
                        label: 'District',
                        value: district!,
                        valueStyle: MuType.bodyMed,
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                height: 140,
                width: 140,
                padding: const EdgeInsets.all(MuSpace.m),
                decoration: BoxDecoration(
                  border: Border.all(color: MuColors.divider, width: 1.5),
                  borderRadius: BorderRadius.circular(MuRadius.qr),
                ),
                child: const Icon(LucideIcons.qrCode, size: 96, color: MuColors.ink),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
