import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'food_item.dart';

@immutable
class Vault {
  final String id;
  final String name;
  final List<String> sharedWith;
  final List<FoodItem> foodItems;

  Vault({
    String? id,
    required this.name,
    this.sharedWith = const [],
    this.foodItems = const [],
  }) : id = id ?? const Uuid().v4();

  factory Vault.fromJson(Map<String, dynamic> json) {
    return Vault(
      id: json['id'] as String,
      name: json['name'] as String,
      sharedWith: List<String>.from(json['sharedWith'] as List),
      foodItems: (json['foodItems'] as List)
          .map((item) => FoodItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sharedWith': sharedWith,
      'foodItems': foodItems.map((item) => item.toJson()).toList(),
    };
  }

  Vault copyWith({
    String? id,
    String? name,
    List<String>? sharedWith,
    List<FoodItem>? foodItems,
  }) {
    return Vault(
      id: id ?? this.id,
      name: name ?? this.name,
      sharedWith: sharedWith ?? this.sharedWith,
      foodItems: foodItems ?? this.foodItems,
    );
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
