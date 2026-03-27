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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepIndicator(1, 'Contact', Icons.phone_outlined, clampedStep),
            _buildConnector(1, clampedStep),
            _buildStepIndicator(2, 'Verify', Icons.check, clampedStep),
            _buildConnector(2, clampedStep),
            _buildStepIndicator(
                3, 'Details', Icons.person_outline, clampedStep),
            _buildConnector(3, clampedStep),
            _buildStepIndicator(
                4, 'Photo', Icons.camera_alt_outlined, clampedStep),
            _buildConnector(4, clampedStep),
            _buildStepIndicator(
                5, 'License', Icons.description_outlined, clampedStep),
          ],
        ),
      ],
    );
  }

  Widget _buildStepIndicator(
      int index, String label, IconData icon, int currentStep) {
    final isCompleted = currentStep > index;
    final isActive = currentStep == index;

    final Color color =
        (isCompleted || isActive) ? RentyColors.primary : Colors.grey.shade300;
    final Color bgColor =
        (isCompleted || isActive) ? RentyColors.primary : Colors.white;
    final Color iconColor = isCompleted
        ? Colors.white
        : (isActive ? Colors.white : Colors.grey.shade400);
    final Color labelColor =
        (isCompleted || isActive) ? RentyColors.primary : Colors.grey.shade400;

    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Icon(
              isCompleted ? Icons.check : icon,
              size: 18,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight:
                (isCompleted || isActive) ? FontWeight.bold : FontWeight.normal,
            color: labelColor,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(int index, int currentStep) {
    final isDone = currentStep > index;
    return Container(
      width: 24,
      height: 1.5,
      margin: const EdgeInsets.only(bottom: 20), // Align with circles
      color: isDone ? RentyColors.primary : Colors.grey.shade300,
    );
  }
}
