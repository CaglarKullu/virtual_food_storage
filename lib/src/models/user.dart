import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as fire_base_auth;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

@immutable
class AppUser {
  final String id;
  final String email;
  final String? name;
  final String? profileImageUrl;
  final List<String> ownedVaults; // IDs of vaults owned by the user
  final List<String> sharedVaults; // IDs of vaults shared with the user

  const AppUser({
    required this.id,
    required this.email,
    this.name,
    this.profileImageUrl,
    this.ownedVaults = const [],
    this.sharedVaults = const [],
  });

  // Constructor for Firebase User
  factory AppUser.fromFirebaseUser(fire_base_auth.User firebaseUser) {
    return AppUser(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName,
      profileImageUrl: firebaseUser.photoURL,
    );
  }

  // Constructor for Supabase User
  factory AppUser.fromSupabaseUser(supabase.User supabaseUser) {
    return AppUser(
      id: supabaseUser.id,
      email: supabaseUser.email ?? '',
      // Add mappings for other fields if available
    );
  }

  // Constructor for custom backend User, adjust as needed
  factory AppUser.fromCustomBackend(Map<String, dynamic> data) {
    return AppUser(
      id: data['id'] as String,
      email: data['email'] as String,
      name: data['name'] as String?,
      profileImageUrl: data['profileImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'ownedVaults': ownedVaults,
      'sharedVaults': sharedVaults,
    };
  }

  // Deserialize the User object from a Map
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String?,
      profileImageUrl: map['profileImageUrl'] as String?,
      ownedVaults: List<String>.from(map['ownedVaults'] ?? []),
      sharedVaults: List<String>.from(map['sharedVaults'] ?? []),
    );
  }

  // Convert User object to JSON String
  String toJson() => json.encode(toMap());

  // Create a User object from a JSON String
  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  // copyWith method for immutability
  AppUser copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImageUrl,
    List<String>? ownedVaults,
    List<String>? sharedVaults,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      ownedVaults: ownedVaults ?? this.ownedVaults,
      sharedVaults: sharedVaults ?? this.sharedVaults,
    );
  }
}
