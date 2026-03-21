import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../booking/car_detail_screen.dart';
import '../../core/theme.dart';
import '../../models/car.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Car> cars = [
    const Car(
        id: '1',
        name: 'Toyota Land Cruiser GX V8',
        location: 'Nairobi',
        year: 2023,
        price: 5500,
        imageUrl: 'https://picsum.photos/id/1015/400/250'),
    const Car(
        id: '2',
        name: 'Mercedes-Benz GLE 450',
        location: 'Mombasa',
        year: 2022,
        price: 7800,
        imageUrl: 'https://picsum.photos/id/1016/400/250'),
    const Car(
        id: '3',
        name: 'Range Rover Evoque',
        location: 'Nairobi',
        year: 2024,
        price: 9200,
        imageUrl: 'https://picsum.photos/id/1018/400/250'),
    const Car(
        id: '4',
        name: 'BMW X5 xDrive40i',
        location: 'Kisumu',
        year: 2021,
        price: 6800,
        imageUrl: 'https://picsum.photos/id/102/400/250'),
    const Car(
        id: '5',
        name: 'Audi Q7 Premium',
        location: 'Nairobi',
        year: 2023,
        price: 8500,
        imageUrl: 'https://picsum.photos/id/103/400/250'),
    const Car(
        id: '6',
        name: 'Toyota Prado TX',
        location: 'Nakuru',
        year: 2020,
        price: 4500,
        imageUrl: 'https://picsum.photos/id/104/400/250'),
    const Car(
        id: '7',
        name: 'Ford Explorer Platinum',
        location: 'Eldoret',
        year: 2022,
        price: 6200,
        imageUrl: 'https://picsum.photos/id/105/400/250'),
    const Car(
        id: '8',
        name: 'Hyundai Palisade',
        location: 'Mombasa',
        year: 2023,
        price: 5900,
        imageUrl: 'https://picsum.photos/id/106/400/250'),
  ];
  List<Car> filteredCars = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCars = cars;
    _searchController.addListener(_filterCars);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCars() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCars = cars
          .where((car) =>
              car.name.toLowerCase().contains(query) ||
              car.location.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> _refreshCars() async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock API refresh
    setState(() {
      cars.shuffle(); // Shuffle for demo
      filteredCars = cars;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drive Your Way",
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: const [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=68"),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCars,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Featured Cars",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search cars or locations...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredCars.length,
                itemBuilder: (context, i) =>
                    _buildCarCard(context, filteredCars[i]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarCard(BuildContext context, Car car) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CarDetailScreen(),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: car.imageUrl,
                height: 140,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(height: 140, color: Colors.white),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 140,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported,
                      size: 50, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.name,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${car.location} • ${car.year}",
                    style: const TextStyle(
                      color: AppTheme.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "KSh ${car.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "/ day",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
