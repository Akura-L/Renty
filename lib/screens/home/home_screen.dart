import 'package:flutter/material.dart';
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
      price: 8500.0,
      imageUrl: 'assets/images/toyota_landcruiser.png',
      rating: 4.9,
      reviewCount: 128,
      topRated: true,
      availableToday: true,
      specs: const [
        '7 Seats',
        'Automatic',
        'Full A/C',
        '300km/day',
        '4WD',
      ],
      about:
          'This well-maintained Land Cruiser GX V8 handles both city streets and off-road adventures with ease. Fully insured, recently serviced, equipped with 4WD, roof rack, and full climate control.',
      reviews: const [
        CarReview(
          initials: 'SK',
          text:
              'Absolutely loved this car! Clean, drives smoothly. David was super helpful at pickup. Will rent again!',
          name: 'Sarah K.',
          monthYear: 'May 2025',
        ),
        CarReview(
          initials: 'MO',
          text:
              'Great for our Maasai Mara trip. Handles city and rough roads perfectly. Highly recommend!',
          name: 'Michael O.',
          monthYear: 'Apr 2025',
        ),
      ],
    ),
    const Car(
      id: '2',
      name: 'Mercedes-Benz GLE 450',
      location: 'Mombasa',
      year: 2022,
      price: 7800.0,
      imageUrl: 'assets/images/mercedes GLE 450.jpeg',
      rating: 4.8,
      reviewCount: 89,
      topRated: true,
      availableToday: true,
      specs: const ['5 Seats', 'Automatic', 'Full A/C', '250km/day', 'AWD'],
      about:
          'Luxury SUV with premium features, ambient lighting, and smooth handling.',
    ),
    const Car(
      id: '3',
      name: 'Range Rover Evoque',
      location: 'Nairobi',
      year: 2024,
      price: 9200.0,
      imageUrl: 'assets/images/range evoque.jpeg',
      rating: 4.9,
      reviewCount: 156,
      topRated: true,
      availableToday: true,
    ),
    const Car(
      id: '4',
      name: 'BMW X5 xDrive40i',
      location: 'Kisumu',
      year: 2021,
      price: 6800.0,
      imageUrl: 'assets/images/BMW X5.jpeg',
      rating: 4.7,
      reviewCount: 112,
      topRated: true,
      availableToday: true,
    ),
    const Car(
      id: '5',
      name: 'Audi Q7 Premium',
      location: 'Nairobi',
      year: 2023,
      price: 8500.0,
      imageUrl: 'assets/images/AudiQ7.jpeg',
      rating: 4.8,
      reviewCount: 95,
      topRated: true,
      availableToday: true,
    ),
    const Car(
      id: '6',
      name: 'Toyota Prado TX',
      location: 'Nakuru',
      year: 2020,
      price: 4500.0,
      imageUrl: 'assets/images/Toyota prado TX.jpeg',
      rating: 4.6,
      reviewCount: 234,
      topRated: true,
      availableToday: true,
    ),
    const Car(
      id: '7',
      name: 'Ford Explorer Platinum',
      location: 'Eldoret',
      year: 2022,
      price: 6200.0,
      imageUrl: 'assets/images/Ford Explorer.jpeg',
      rating: 4.7,
      reviewCount: 78,
      topRated: true,
      availableToday: true,
    ),
    const Car(
      id: '8',
      name: 'Hyundai Palisade',
      location: 'Mombasa',
      year: 2023,
      price: 5900.0,
      imageUrl: 'assets/images/Hyundai.jpeg',
      rating: 4.8,
      reviewCount: 145,
      topRated: true,
      availableToday: true,
    ),
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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refreshCars,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.screenPadding(context),
            vertical: AppTheme.kPaddingLarge * 0.7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getGreeting(),
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.grey,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Drive Your Way',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.dark,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search cars, locations...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: AppTheme.kPaddingMedium * 0.75),
              Wrap(
                spacing: Responsive.horizontalGap(context),
                children: const [
                  _HomeMiniChip(label: 'All', active: true),
                  _HomeMiniChip(label: 'SUV'),
                ],
              ),
              SizedBox(height: AppTheme.kPaddingMedium),
              Text(
                "Available Cars",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossCount = Responsive.dynamicGridCount(context);
                  final aspectRatio = crossCount == 1
                      ? 0.75
                      : (constraints.maxWidth / crossCount - 20) /
                          AppTheme.kCardImageHeight *
                          1.1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossCount,
                      childAspectRatio: aspectRatio,
                      crossAxisSpacing: Responsive.horizontalGap(context) * 2,
                      mainAxisSpacing: AppTheme.kPaddingSmall * 1.3,
                    ),
                    itemCount: filteredCars.length,
                    itemBuilder: (context, i) =>
                        _buildCarCard(context, filteredCars[i]),
                  );
                },
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
          builder: (_) => CarDetailScreen(car: car),
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
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Image.asset(
                  car.imageUrl,
                  height: AppTheme.kCardImageHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: AppTheme.kCardImageHeight,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported,
                        size: 50, color: Colors.grey),
                  ),
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

class _HomeMiniChip extends StatelessWidget {
  final String label;
  final bool active;
  const _HomeMiniChip({required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppTheme.primary10 : Colors.grey[100],
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: active ? AppTheme.primary : AppTheme.grey10,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: active ? AppTheme.primary : AppTheme.grey700,
          fontSize: 12,
        ),
      ),
    );
  }
}
