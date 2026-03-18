import 'package:flutter/material.dart';
import 'photo_screen.dart';
import 'package:flutter/services.dart';
import '../core/theme.dart';

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
  DateTime? _dob;
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
      setState(() => _dob = picked);
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
      appBar: AppBar(
        title: const Text("Tell us about yourself"),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextFormField(
                controller: _firstName,
                decoration: const InputDecoration(labelText: "First name"),
                validator: (v) => v!.isEmpty ? 'Enter first name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastName,
                decoration: const InputDecoration(labelText: "Last name"),
                validator: (v) => v!.isEmpty ? 'Enter last name' : null,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDob(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Date of birth",
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: _dob == null
                          ? ''
                          : '${_dob!.toLocal()}'.split(' ')[0],
                    ),
                    validator: (v) => _dob == null ? 'Select DOB' : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _location,
                decoration: const InputDecoration(labelText: "City / Location"),
                validator: (v) => v!.isEmpty ? 'Enter location' : null,
              ),
              const SizedBox(height: 40),
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
    super.dispose();
  }
}
