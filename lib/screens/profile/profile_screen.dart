import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/favourites_provider.dart';
import '../../../providers/bookings_provider.dart';
import '../../../core/theme.dart';
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
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(RentySpacing.xl),
        child: Column(
          children: [
            // Profile Header
            Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/300?img=68'),
                  backgroundColor: RentyColors.primaryLight,
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: RentyColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              userName ?? 'User',
              style: RentyTextStyles.headingXL,
            ),
            Text(
              userEmail ?? 'email@example.com',
              style: RentyTextStyles.bodyM,
            ),
            const SizedBox(height: 32),

            // Stats Cards - Dynamic
            Consumer2<BookingsProvider, FavouritesProvider>(
              builder: (context, bookingsProvider, favouritesProvider, child) {
                return Row(
                  children: [
                    Expanded(
                      child: _statCard(
                        'Bookings',
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
            const SizedBox(height: 32),

            // Account Info List
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _infoRow(Icons.phone_outlined, 'Phone', userPhone),
                    const Divider(),
                    _infoRow(Icons.location_on_outlined, 'City', userCity),
                    const Divider(),
                    _infoRow(Icons.email_outlined, 'Email', userEmail),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quick Actions',
                style: RentyTextStyles.headingM,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Settings'),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings coming soon')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text('Help Center'),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Help Center coming soon')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text('My Bookings'),
                    trailing: const Icon(Icons.chevron_right, size: 20),
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
                    leading: const Icon(Icons.favorite_border),
                    title: const Text('Favourites'),
                    trailing: const Icon(Icons.chevron_right, size: 20),
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
                    leading: const Icon(Icons.chat_bubble_outline),
                    title: const Text('Messages'),
                    trailing: const Icon(Icons.chevron_right, size: 20),
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
            const SizedBox(height: 24),
            // Action Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit_outlined, color: Colors.white),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RentyColors.surface,
        borderRadius: BorderRadius.circular(RentyRadius.lg),
        border: Border.all(color: RentyColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: RentyColors.primary),
          const SizedBox(height: 8),
          Text(
            count,
            style:
                RentyTextStyles.headingXL.copyWith(color: RentyColors.primary),
          ),
          Text(title, style: RentyTextStyles.caption),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: RentyColors.textSecondary, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: RentyTextStyles.caption),
                Text(value ?? 'N/A', style: RentyTextStyles.labelL),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: RentyColors.border, size: 18),
        ],
      ),
    );
  }
}
