import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/favourites_provider.dart';
import '../../../providers/bookings_provider.dart';
import '../../../core/theme.dart';
import '../../../auth/welcome_screen.dart';
import 'favourites_screen.dart';
import 'my_bookings_screen.dart';
import 'messages_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userCity;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('common_name') ?? 'James Mwangi';
      userEmail = prefs.getString('common_email') ?? 'james.mwangi@email.com';
      userPhone = prefs.getString('common_phone') ?? '+254 700 123 456';
      userCity = prefs.getString('common_city') ?? 'Nairobi';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/welcome',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile Header
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      const NetworkImage('https://i.pravatar.cc/300?img=68'),
                  backgroundColor: AppTheme.primary.withOpacity(0.1),
                ),
                Positioned(
                  bottom: -10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child:
                        const Icon(Icons.edit, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              userName ?? 'User',
              style:
                  GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              userEmail ?? 'email@example.com',
              style: const TextStyle(color: AppTheme.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Stats Cards - Dynamic
            Consumer2<BookingsProvider, FavouritesProvider>(
              builder: (context, bookingsProvider, favouritesProvider, child) {
                return Row(
                  children: [
                    Expanded(
                      child: _statCard(
                        'Total Bookings',
                        bookingsProvider.count.toString(),
                        Icons.calendar_today,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _statCard(
                        'Favourites',
                        favouritesProvider.count.toString(),
                        Icons.favorite,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),

            // Account Info List
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _infoRow(Icons.phone, 'Phone', userPhone),
                    const Divider(),
                    _infoRow(Icons.location_on, 'City', userCity),
                    const Divider(),
                    _infoRow(Icons.email, 'Email', userEmail),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Quick Actions Section (from task ListTiles)
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings coming soon')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help Center'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Help Center coming soon')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('My Bookings'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyBookingsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favourites'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FavouritesScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text('Messages'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MessagesScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Action Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit profile tapped')),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                onPressed: _logout,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String count, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: AppTheme.primary),
          const SizedBox(height: 8),
          Text(
            count,
            style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary),
          ),
          Text(title, style: const TextStyle(color: AppTheme.grey)),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(color: AppTheme.grey, fontSize: 12)),
                Text(value ?? 'N/A',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const Icon(Icons.edit, color: AppTheme.grey, size: 18),
        ],
      ),
    );
  }
}
