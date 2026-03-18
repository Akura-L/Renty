import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../booking/car_detail_screen.dart';
import '../../core/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const Text("Drive Your Way",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          const CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=68"),
              radius: 20),
        ]),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Featured Cars",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16),
              itemCount: 4,
              itemBuilder: (context, i) => _buildCarCard(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildCarCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const CarDetailScreen())),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)
            ]),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: "https://picsum.photos/id/1015/300/200",
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Toyota Land Cruiser GX V8",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Nairobi • 2023",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(height: 8),
                  Text("KSh 5,500",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF00BFA5),
                          fontWeight: FontWeight.bold)),
                  Text("/ day", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF00BFA5),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), label: "Favourites"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: "Bookings"),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: "Messages"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Profile"),
      ],
      onTap: (index) {
        // TODO: Switch between tabs (we'll make separate screens next)
      },
    );
  }
}
