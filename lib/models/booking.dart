import 'dart:convert';
import 'package:flutter/material.dart';
import 'car.dart';

class Booking {
  final String id;
  final Car car;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String reference;
  final String ownerName;
  final String pickupLocation;
  final double totalPaid;
  final String ownerPhone;

  const Booking({
    required this.id,
    required this.car,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.reference,
    required this.ownerName,
    required this.pickupLocation,
    required this.totalPaid,
    required this.ownerPhone,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      car: Car.fromJson(json['car'] ?? {}),
      startDate: DateTime.parse(json['startDate'] ?? ''),
      endDate: DateTime.parse(json['endDate'] ?? ''),
      status: json['status'] ?? '',
      reference: json['reference'] ?? '',
      ownerName: json['ownerName'] ?? '',
      pickupLocation: json['pickupLocation'] ?? '',
      totalPaid: (json['totalPaid'] ?? 0).toDouble(),
      ownerPhone: json['ownerPhone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'car': car.toJson(),
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'status': status,
        'reference': reference,
        'ownerName': ownerName,
        'pickupLocation': pickupLocation,
        'totalPaid': totalPaid,
        'ownerPhone': ownerPhone,
      };
}
