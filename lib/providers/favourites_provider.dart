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
