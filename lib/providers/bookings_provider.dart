import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking.dart';
import '../models/car.dart';

class BookingsProvider extends ChangeNotifier {
  static const String _key = 'bookings_data';
  List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;
  int get count => _bookings.length;
  bool get isEmpty => _bookings.isEmpty;

  BookingsProvider() {
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        _bookings = jsonList.map((json) => Booking.fromJson(json)).toList();
      } catch (e) {
        _bookings = [];
      }
    } else {
      _bookings = [];
    }
    notifyListeners();
  }

  Future<void> addBooking(Booking booking) async {
    _bookings.add(booking);
    await _saveBookings();
    notifyListeners();
  }

  Future<void> removeBooking(String id) async {
    _bookings.removeWhere((b) => b.id == id);
    await _saveBookings();
    notifyListeners();
  }

  Future<void> _saveBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _bookings.map((b) => b.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  // Sample booking generator for testing
  Booking generateSampleBooking(String id) {
    return Booking(
      id: id,
      car: const Car(
        id: '1',
        name: 'Toyota Land Cruiser GX V8',
        location: 'Nairobi',
        year: 2023,
        price: 5500,
        imageUrl: 'https://picsum.photos/id/1015/400/250',
      ),
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
      status: 'Confirmed',
    );
  }
}
