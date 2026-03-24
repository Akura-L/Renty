import 'package:flutter/material.dart';
import 'photo_screen.dart';
import 'package:flutter/services.dart';
import '../core/theme.dart';
import 'widgets/auth_flow_stepper.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});
  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController(text: "James");
  final _lastName = TextEditingController(text: "Mwangi");
  final _location = TextEditingController();
  final _emergencyContact = TextEditingController(text: '+254 7XX XXX XXX');
  DateTime? _dob;
  final TextEditingController _dobController = TextEditingController();
  String _gender = 'Male';
  bool _isLoading = false;

  Future<void> _selectDob(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dob = picked;
        _dobController.text =
            '${picked.day.toString().padLeft(2, '0')}  /  ${picked.month.toString().padLeft(2, '0')}  /  ${picked.year}';
      });
    }
  }

  void _continue() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // Simulate save
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PhotoScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthFlowStepper(currentStep: 3),
              const SizedBox(height: 18),
              Text(
                'Tell us about yourself',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.dark,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'This information will appear on your public Renty profile.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstName,
                      decoration:
                          const InputDecoration(labelText: "First Name"),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Enter first name'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _lastName,
                      decoration: const InputDecoration(labelText: "Last Name"),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Enter last name'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Date of Birth',
                style: TextStyle(
                  color: AppTheme.grey700,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDob(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                      labelText: 'Day / Month / Year',
                    ),
                    controller: _dobController,
                    validator: (_) => _dob == null ? 'Select DOB' : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Gender',
                style: TextStyle(
                  color: AppTheme.grey700,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() => _gender = v);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() => _gender = v);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _location,
                decoration: const InputDecoration(labelText: "City / Location"),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter location' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emergencyContact,
                decoration: const InputDecoration(
                  labelText: "Emergency Contact (optional)",
                  hintText: '+254 7XX XXX XXX',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Only contacted during roadside emergencies',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.grey,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 18),
              Text(
                'Your personal details are protected and will never be shared with other users or third parties.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.grey,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _continue,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _location.dispose();
    _emergencyContact.dispose();
    _dobController.dispose();
    super.dispose();
  }
}
