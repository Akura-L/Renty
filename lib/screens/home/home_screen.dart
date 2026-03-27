import 'package:flutter/material.dart';
import '../booking/car_detail_screen.dart';
import '../../core/theme.dart';
import '../../core/responsive.dart';
import '../../models/car.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Featured';
  final List<String> _categories = [
    'Featured',
    'Best Value',
    'Luxury',
    'Electric'
  ];
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
      specs: [
        '7 Seats',
        'Automatic',
        'Full A/C',
        '300km/day',
        '4WD',
      ],
      about:
          'This well-maintained Land Cruiser GX V8 handles both city streets and off-road adventures with ease. Fully insured, recently serviced, equipped with 4WD, roof rack, and full climate control.',
      reviews: [
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
      imageUrl: 'assets/images/mercedes_gle_450.jpeg',
      rating: 4.8,
      reviewCount: 89,
      topRated: true,
      availableToday: true,
      specs: ['5 Seats', 'Automatic', 'Full A/C', '250km/day', 'AWD'],
      about:
          'Luxury SUV with premium features, ambient lighting, and smooth handling.',
    ),
    const Car(
      id: '3',
      name: 'Range Rover Evoque',
      location: 'Nairobi',
      year: 2024,
      price: 9200.0,
      imageUrl: 'assets/images/range_evoque.jpeg',
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
      imageUrl: 'assets/images/bmw_x5.jpeg',
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
      imageUrl: 'assets/images/audi_q7.jpeg',
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
      imageUrl: 'assets/images/toyota_prado_tx.jpeg',
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
      imageUrl: 'assets/images/ford_explorer.jpeg',
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
      filteredCars = cars.where((car) {
        final matchesSearch = query.isEmpty ||
            car.name.toLowerCase().contains(query) ||
            car.location.toLowerCase().contains(query);

        final matchesCategory = _selectedCategory == 'Featured' ||
            (_selectedCategory == 'Electric' &&
                (car.name.toLowerCase().contains('ev') ||
                    car.name.toLowerCase().contains('audi'))) ||
            (_selectedCategory == 'Luxury' &&
                (car.name.toLowerCase().contains('mercedes') ||
                    car.name.toLowerCase().contains('range') ||
                    car.name.toLowerCase().contains('bmw') ||
                    car.name.toLowerCase().contains('audi'))) ||
            (_selectedCategory == 'Best Value' && (car.price < 6000));

        return matchesSearch && matchesCategory;
      }).toList();
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
            vertical: RentySpacing.lg * 0.7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getGreeting(),
                style: RentyTextStyles.headingS,
              ),
              const SizedBox(height: 6),
              const Text(
                'Drive Your Way',
                style: RentyTextStyles.headingL,
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search cars, locations...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(RentyRadius.md)),
                  filled: true,
                  fillColor: RentyColors.surface,
                ),
              ),
              const SizedBox(height: RentySpacing.md * 0.75),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      isSelected: true,
                      onTap: () {
                        // All filter already active, or could clear category filter
                      },
                    ),
                    _FilterChip(label: 'SUV', onTap: () {}),
                    _FilterChip(label: 'Sedan', onTap: () {}),
                    _FilterChip(label: 'Luxury', onTap: () {}),
                    _FilterChip(label: 'Electric', onTap: () {}),
                    _FilterChip(label: 'Pickup', onTap: () {}),
                  ],
                ),
              ),
              const SizedBox(height: RentySpacing.md),
              const Text(
                "Featured Cars",
                style: RentyTextStyles.headingL,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                            _filterCars();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? RentyColors.primaryLight
                                : RentyColors.surface,
                            borderRadius:
                                BorderRadius.circular(RentyRadius.pill),
                            border: Border.all(
                              color: isSelected
                                  ? RentyColors.primary
                                  : RentyColors.border,
                            ),
                          ),
                          child: Text(
                            category,
                            style: RentyTextStyles.labelL.copyWith(
                              color: isSelected
                                  ? RentyColors.primary
                                  : RentyColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossCount = Responsive.dynamicGridCount(context);
                  final aspectRatio = crossCount == 1 ? 0.85 : 0.78;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossCount,
                      childAspectRatio: aspectRatio,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
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
        decoration: RentyDecorations.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(RentyRadius.lg)),
              child: Image.asset(
                car.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120,
                  color: RentyColors.surface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.name,
                    style: RentyTextStyles.headingS,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${car.location}, ${car.year}',
                    style: RentyTextStyles.bodyS,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: RentyColors.primaryLight,
                          borderRadius: BorderRadius.circular(RentyRadius.xs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star,
                                size: 12, color: RentyColors.primary),
                            const SizedBox(width: 2),
                            Text(
                              car.rating.toStringAsFixed(1),
                              style: RentyTextStyles.priceSmall
                                  .copyWith(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${car.reviewCount})',
                        style: RentyTextStyles.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "KSh ${car.price.toStringAsFixed(0)}",
                        style: RentyTextStyles.price,
                      ),
                      const Text(
                        "/day",
                        style: RentyTextStyles.bodyS,
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? RentyColors.primaryLight : RentyColors.surface,
          borderRadius: BorderRadius.circular(RentyRadius.pill),
          border: Border.all(
            color: isSelected ? RentyColors.primary : RentyColors.border,
          ),
        ),
        child: Text(
          label,
          style: RentyTextStyles.labelL.copyWith(
            color: isSelected ? RentyColors.primary : RentyColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
