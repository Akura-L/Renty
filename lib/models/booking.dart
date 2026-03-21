import 'dart:convert';
import 'package:flutter/material.dart';
import 'car.dart';

class Booking {
  final String id;
  final Car car;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  const Booking({
    required this.id,
    required this.car,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      car: Car.fromJson(json['car'] ?? {}),
      startDate: DateTime.parse(json['startDate'] ?? ''),
      endDate: DateTime.parse(json['endDate'] ?? ''),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'car': car.toJson(),
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'status': status,
      };
}
