import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';

/// "Welcome back" summary card with karma/level/rank — the home dashboard's
/// hero widget.
class ProgressSummaryCard extends StatelessWidget {
  const ProgressSummaryCard({required this.summary, super.key});

  final MyProgressSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: MulearnGradients.trusty,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, ${summary.fullName.split(' ').first}',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _Stat(label: 'Karma', value: '${summary.karma}'),
              _Stat(label: 'Level', value: summary.level ?? '—'),
              if (summary.rank != null)
                _Stat(label: 'Rank', value: '#${summary.rank}'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
