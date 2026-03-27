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
          ? RentyColors.primary
          : isDone
              ? RentyColors.primary
              : RentyColors.textDisabled;

      final weight = isActive ? FontWeight.w700 : FontWeight.w600;

      return Expanded(
        child: Column(
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: color, fontWeight: weight, fontSize: 11),
            ),
            const SizedBox(height: 6),
            Container(
              height: 3,
              decoration: BoxDecoration(
                color: isActive || isDone ? RentyColors.primary : RentyColors.surface,
                borderRadius: BorderRadius.circular(2),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 2),
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
          style: RentyTextStyles.labelL.copyWith(color: RentyColors.primary),
        ),
        const SizedBox(height: 12),
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

