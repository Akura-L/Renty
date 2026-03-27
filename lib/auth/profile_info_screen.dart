import 'package:flutter/material.dart';
import 'photo_screen.dart';
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
  final _emergencyContact = TextEditingController(text: '+254 7XX XXX XXX');
  DateTime? _dob;
  final TextEditingController _dobController = TextEditingController();
  String? _selectedGender;
  String? _selectedLocation;
  bool _isLoading = false;

  final List<String> kenyanCounties = [
    'Baringo',
    'Bomet',
    'Bungoma',
    'Busia',
    'Elgeyo-Marakwet',
    'Embu',
    'Garissa',
    'Homa Bay',
    'Isiolo',
    'Kajiado',
    'Kakamega',
    'Kericho',
    'Kiambu',
    'Kilifi',
    'Kirinyaga',
    'Kisii',
    'Kisumu',
    'Kitui',
    'Kwale',
    'Laikipia',
    'Lamu',
    'Machakos',
    'Makueni',
    'Mandera',
    'Marsabit',
    'Meru',
    'Migori',
    'Mombasa',
    "Murang'a",
    'Nairobi',
    'Nakuru',
    'Nandi',
    'Narok',
    'Nyamira',
    'Nyandarua',
    'Nyeri',
    'Samburu',
    'Siaya',
    'Taita-Taveta',
    'Tana River',
    'Tharaka-Nithi',
    'Trans Nzoia',
    'Turkana',
    'Uasin Gishu',
    'Vihiga',
    'Wajir',
    'West Pokot',
  ];

  final List<String> genders = ['Male', 'Female', 'Other'];

  Future<void> _selectDob(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: RentyColors.primary),
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(RentySpacing.xl),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthFlowStepper(currentStep: 3),
                  const SizedBox(height: 18),
                  const Text(
                    'Tell us about yourself',
                    style: RentyTextStyles.headingXL,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'This information will appear on your public Renty profile.',
                    style: RentyTextStyles.bodyM,
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
                          decoration:
                              const InputDecoration(labelText: "Last Name"),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Enter last name'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Date of Birth',
                    style: RentyTextStyles.labelL,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectDob(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: 'Day / Month / Year',
                        ),
                        controller: _dobController,
                        validator: (_) => _dob == null ? 'Select DOB' : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Gender',
                    style: RentyTextStyles.labelL,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration:
                        const InputDecoration(labelText: 'Select Gender'),
                    items: genders.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedGender = value),
                    validator: (v) => v == null ? 'Select your gender' : null,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'County / Location',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    decoration:
                        const InputDecoration(labelText: 'Select County'),
                    items: kenyanCounties.map((county) {
                      return DropdownMenuItem(
                        value: county,
                        child: Text(county),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedLocation = value),
                    validator: (v) => v == null ? 'Select your county' : null,
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
                  const Text(
                    'Only contacted during roadside emergencies',
                    style: RentyTextStyles.caption,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Your personal details are protected and will never be shared with other users or third parties.',
                    style: RentyTextStyles.caption,
                  ),
                  const SizedBox(height: 32),
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _emergencyContact.dispose();
    _dobController.dispose();
    super.dispose();
  }
}
