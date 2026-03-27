import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class BookingFlowStepper extends StatelessWidget {
  final int currentStep; // 1..5

  const BookingFlowStepper({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final clampedStep = currentStep.clamp(1, 5);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepIndicator(1, 'Dates', Icons.calendar_today_outlined, clampedStep),
        _buildConnector(1, clampedStep),
        _buildStepIndicator(2, 'Driver', Icons.person_outline, clampedStep),
        _buildConnector(2, clampedStep),
        _buildStepIndicator(3, 'Terms', Icons.description_outlined, clampedStep),
        _buildConnector(3, clampedStep),
        _buildStepIndicator(4, 'Payment', Icons.credit_card_outlined, clampedStep),
        _buildConnector(4, clampedStep),
        _buildStepIndicator(5, 'Done', Icons.check_circle_outline, clampedStep),
      ],
    );
  }

  Widget _buildStepIndicator(int index, String label, IconData icon, int currentStep) {
    final isCompleted = currentStep > index;
    final isActive = currentStep == index;

    final Color color = (isCompleted || isActive) ? RentyColors.primary : Colors.grey.shade300;
    final Color bgColor = (isCompleted || isActive) ? RentyColors.primary : Colors.white;
    final Color iconColor = isCompleted ? Colors.white : (isActive ? Colors.white : Colors.grey.shade400);
    final Color labelColor = (isCompleted || isActive) ? RentyColors.primary : Colors.grey.shade400;

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
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
              size: 16,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: (isCompleted || isActive) ? FontWeight.bold : FontWeight.normal,
            color: labelColor,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(int index, int currentStep) {
    final isDone = currentStep > index;
    return Container(
      width: 20,
      height: 1.5,
      margin: const EdgeInsets.only(bottom: 16), // Align with circles
      color: isDone ? RentyColors.primary : Colors.grey.shade300,
    );
  }
}
