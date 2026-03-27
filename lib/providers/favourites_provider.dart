import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/car.dart';

class FavouritesProvider extends ChangeNotifier {
  static const String _key = 'favourite_car_ids';
  Set<String> _favouriteCarIds = {};

  // Static all cars matching home_screen.dart
  static final List<Car> allCars = [
    const Car(
      id: '1',
      name: 'Toyota Land Cruiser',
      subName: 'GX V8 2023',
      location: 'Nairobi',
      exactLocation: 'Nairobi, Westlands',
      year: 2023,
      price: 8500.0,
      imageUrl: 'assets/images/toyota_landcruiser.png',
      category: 'SUV',
      rating: 4.9,
      reviewCount: 128,
      topRated: true,
      availableToday: true,
      specs: [
        '7 Seats',
        'Automatic',
        'Diesel',
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
      name: 'BMW 5 Series',
      subName: '530i M Sport',
      location: 'Nairobi',
      exactLocation: 'Westlands',
      year: 2022,
      price: 12000.0,
      imageUrl: 'assets/images/bmw_x5.jpeg',
      category: 'Sport',
      rating: 4.8,
      reviewCount: 89,
      featured: true,
      availableToday: true,
      specs: ['5 Seats', 'Automatic', 'Petrol', 'Full A/C', '250km/day', 'RWD'],
      about:
          'Luxury sedan with sporty performance, premium interior, and advanced technology.',
    ),
    const Car(
      id: '3',
      name: 'Mercedes GLE 450',
      subName: 'AMG 2023',
      location: 'Nairobi',
      exactLocation: 'Karen',
      year: 2023,
      price: 15000.0,
      imageUrl: 'assets/images/mercedes_gle_450.jpeg',
      category: 'Luxury',
      rating: 4.9,
      reviewCount: 156,
      luxury: true,
      availableToday: true,
      specs: ['5 Seats', 'Automatic', 'Hybrid', 'Full A/C', '200km/day', 'AWD'],
      about:
          'The GLE 450 AMG combines luxury with power, featuring a spacious cabin and cutting-edge features.',
    ),
    const Car(
      id: '4',
      name: 'Range Rover Evoque',
      subName: 'Dynamic HSE',
      location: 'Nairobi',
      exactLocation: 'Gigiri',
      year: 2024,
      price: 18000.0,
      imageUrl: 'assets/images/range_evoque.jpeg',
      category: 'Luxury',
      rating: 4.9,
      reviewCount: 112,
      luxury: true,
      availableToday: true,
      specs: ['5 Seats', 'Automatic', 'Petrol', 'Full A/C', '150km/day', 'AWD'],
      about: 'Compact luxury SUV with iconic design and refined performance.',
    ),
  ];

  Set<String> get favouriteCarIds => _favouriteCarIds;
  List<Car> get favouriteCars =>
      allCars.where((car) => _favouriteCarIds.contains(car.id)).toList();
  List<Car> get recommendationCars => allCars
      .where((car) => !_favouriteCarIds.contains(car.id))
      .take(4)
      .toList();
  bool isFavourite(String carId) => _favouriteCarIds.contains(carId);
  int get count => _favouriteCarIds.length;

  FavouritesProvider() {
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    _favouriteCarIds = ids.map((id) => id).toSet();
    notifyListeners();
  }

  Future<void> toggleFavourite(String carId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favouriteCarIds.contains(carId)) {
      _favouriteCarIds.remove(carId);
    } else {
      _favouriteCarIds.add(carId);
    }
    await prefs.setStringList(_key, _favouriteCarIds.toList());
    notifyListeners();
  }
}
