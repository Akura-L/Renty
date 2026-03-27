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
  final _emergencyContact = TextEditingController();

  final _dayController = TextEditingController(text: '15');
  final _monthController = TextEditingController(text: '03');
  final _yearController = TextEditingController(text: '1990');

  String? _selectedGender = 'Male';
  String? _selectedLocation = 'Nairobi';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child:
                const Icon(Icons.chevron_left, color: Colors.black, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Step 3 of 5',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const AuthFlowStepper(currentStep: 3),
                  const SizedBox(height: 32),
                  const Text(
                    'Tell us about yourself',
                    style: RentyTextStyles.headingXL,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'This information will appear on your public\nRenty profile.',
                    style: RentyTextStyles.bodyM,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'First Name',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF2D3E50),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _firstName,
                              decoration: InputDecoration(
                                hintText: 'James',
                                fillColor: const Color(0xFFF8F9FA),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Required'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Last Name',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF2D3E50),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _lastName,
                              decoration: InputDecoration(
                                hintText: 'Mwangi',
                                fillColor: const Color(0xFFF8F9FA),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Required'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Date of Birth',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3E50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildDobField(_dayController, 'Day'),
                      const SizedBox(width: 12),
                      _buildDobField(_monthController, 'Month'),
                      const SizedBox(width: 12),
                      _buildDobField(_yearController, 'Year', flex: 2),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3E50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFF8F9FA),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: genders.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedGender = value),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'City / Location',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3E50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFF8F9FA),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: kenyanCounties.map((county) {
                      return DropdownMenuItem(
                        value: county,
                        child: Text(county),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedLocation = value),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Emergency Contact (optional)',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3E50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emergencyContact,
                    decoration: InputDecoration(
                      hintText: '+254 7XX XXX XXX',
                      fillColor: const Color(0xFFF8F9FA),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Only contacted during roadside emergencies',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F6F6),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFD1EEEE)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: RentyColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check,
                              color: Colors.white, size: 14),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Your personal details are protected and will never be shared with other users or third parties.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF2D3E50),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: RentyColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              "Continue",
                              style: RentyTextStyles.button,
                            ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDobField(TextEditingController controller, String label,
      {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: const Color(0xFFF8F9FA),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _emergencyContact.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }
}
