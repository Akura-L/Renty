import 'package:flutter/material.dart';

import '../../core/theme.dart';

class AuthFlowStepper extends StatelessWidget {
  final int currentStep; // 1..5

  const AuthFlowStepper({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final clampedStep = currentStep.clamp(1, 5);

    Widget stepLabel({
      required String label,
      required int stepIndex,
    }) {
      final isActive = clampedStep == stepIndex;
      final isDone = clampedStep > stepIndex;

      final color = isActive
          ? AppTheme.primary
          : isDone
              ? AppTheme.primary.withOpacity(0.9)
              : AppTheme.grey;

      final weight = isActive ? FontWeight.w700 : FontWeight.w600;

      return Expanded(
        child: Column(
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: color, fontWeight: weight, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              width: 26,
              decoration: BoxDecoration(
                color: isActive || isDone ? AppTheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step $clampedStep of 5',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stepLabel(label: 'Contact', stepIndex: 1),
            stepLabel(label: 'Verify', stepIndex: 2),
            stepLabel(label: 'Details', stepIndex: 3),
            stepLabel(label: 'Photo', stepIndex: 4),
            stepLabel(label: 'License', stepIndex: 5),
          ],
        ),
      ],
    );
  }
}

