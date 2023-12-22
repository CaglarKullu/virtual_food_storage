import 'package:flutter/foundation.dart';

@immutable
class FoodItem {
  final String id;
  final String name;
  final int quantity;
  final DateTime expirationDate;
  final String category;

  const FoodItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.expirationDate,
    required this.category,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      expirationDate: DateTime.parse(json['expirationDate']),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'expirationDate': expirationDate.toIso8601String(),
      'category': category,
    };
  }

  // copyWith method for immutability
  FoodItem copyWith({
    String? id,
    String? name,
    int? quantity,
    DateTime? expirationDate,
    String? category,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      expirationDate: expirationDate ?? this.expirationDate,
      category: category ?? this.category,
    );
  }

  // Factory methods for Firebase, Supabase, and Custom Backend
  factory FoodItem.fromFirebase(Map<String, dynamic> data) {
    // Implement conversion logic specific to Firebase
    // Assuming the data structure is the same
    return FoodItem.fromJson(data);
  }

  factory FoodItem.fromSupabase(Map<String, dynamic> data) {
    // Implement conversion logic specific to Supabase
    // Assuming the data structure is the same
    return FoodItem.fromJson(data);
  }

  factory FoodItem.fromCustomBackend(Map<String, dynamic> data) {
    // Implement conversion logic specific to your custom backend
    // Assuming the data structure is the same
    return FoodItem.fromJson(data);
  }

  // Specific methods for different backends
  Map<String, dynamic> toFirebase() {
    // Add any Firebase-specific logic if needed
    return toJson();
  }

  Map<String, dynamic> toSupabase() {
    // Add any Supabase-specific logic if needed
    return toJson();
  }

  Map<String, dynamic> toCustomBackend() {
    // Add any custom backend-specific logic if needed
    return toJson();
  }
}
