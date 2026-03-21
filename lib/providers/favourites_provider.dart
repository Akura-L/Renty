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

  Set<String> get favouriteCarIds => _favouriteCarIds;
  List<Car> get favouriteCars =>
      allCars.where((car) => _favouriteCarIds.contains(car.id)).toList();
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
