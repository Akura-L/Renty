import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../booking/car_detail_screen.dart';
import '../../core/theme.dart';
import '../../core/responsive.dart';
import '../../models/car.dart';
import '../../providers/favourites_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'SUV', 'Sport', 'Luxury'];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final allCars = FavouritesProvider.allCars;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Drive Your Way',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3E50),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: const Icon(Icons.notifications_none,
                        color: Colors.grey, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search cars, locations...',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          icon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: RentyColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Categories
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? RentyColors.primary
                              : const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? RentyColors.primary
                                : Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          children: [
                            if (cat == 'All')
                              Icon(Icons.grid_view_rounded,
                                  size: 18,
                                  color:
                                      isSelected ? Colors.white : Colors.grey),
                            if (cat == 'SUV')
                              Icon(Icons.directions_car_outlined,
                                  size: 18,
                                  color:
                                      isSelected ? Colors.white : Colors.grey),
                            if (cat == 'Sport')
                              Icon(Icons.bolt_outlined,
                                  size: 18,
                                  color:
                                      isSelected ? Colors.white : Colors.grey),
                            if (cat == 'Luxury')
                              Icon(Icons.auto_awesome_outlined,
                                  size: 18,
                                  color:
                                      isSelected ? Colors.white : Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              cat,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              // Featured Cars
              _buildSectionHeader('Featured Cars', 'Top picks this week'),
              const SizedBox(height: 16),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      allCars.where((c) => c.topRated || c.featured).length,
                  itemBuilder: (context, index) {
                    final car = allCars
                        .where((c) => c.topRated || c.featured)
                        .toList()[index];
                    return _buildCarCard(car);
                  },
                ),
              ),

              const SizedBox(height: 32),

              // Near You
              _buildSectionHeader(
                  'Near You · Nairobi', 'Available for pickup today'),
              const SizedBox(height: 16),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      allCars.where((c) => c.location == 'Nairobi').length,
                  itemBuilder: (context, index) {
                    final car = allCars
                        .where((c) => c.location == 'Nairobi')
                        .toList()[index];
                    return _buildCarCard(car);
                  },
                ),
              ),

              const SizedBox(height: 32),

              // Popular
              _buildSectionHeader('Popular This Week', 'Most booked cars'),
              const SizedBox(height: 16),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allCars.length,
                  itemBuilder: (context, index) {
                    final car = allCars[index];
                    return _buildCarCard(car);
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3E50),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Row(
            children: [
              Text('See all',
                  style: TextStyle(color: RentyColors.primary, fontSize: 13)),
              Icon(Icons.chevron_right, color: RentyColors.primary, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCarCard(Car car) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CarDetailScreen(car: car),
          ),
        );
      },
      child: Container(
        width: 240,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Image.asset(
                    car.imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: car.luxury
                          ? Colors.purple.withOpacity(0.8)
                          : car.topRated
                              ? const Color(0xFF149C9C).withOpacity(0.8)
                              : Colors.orange.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      car.luxury
                          ? 'Luxury'
                          : car.topRated
                              ? 'Top Rated'
                              : 'Featured',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Consumer<FavouritesProvider>(
                    builder: (context, provider, _) {
                      final isFav = provider.isFavourite(car.id);
                      return GestureDetector(
                        onTap: () => provider.toggleFavourite(car.id),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                            size: 18,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.white, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          car.exactLocation.split(',').last.trim(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3E50),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    car.subName,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color(0xFFFFC107), size: 16),
                          const SizedBox(width: 4),
                          Text(
                            car.rating.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'KSh ${car.price.toInt().toString()}',
                              style: const TextStyle(
                                color: RentyColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const TextSpan(
                              text: '/day',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
