import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as fire_base_auth;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AppUser {
  final String id;
  final String email;
  final String? name;
  final String? profileImageUrl;
  // Add other common attributes as needed

  AppUser(
      {required this.id, required this.email, this.name, this.profileImageUrl});

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
    };
  }

  // Deserialize the User object from a Map
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String?,
      profileImageUrl: map['profileImageUrl'] as String?,
    );
  }

  // Optional: Create a method to convert User object to JSON String
  String toJson() => json.encode(toMap());

  // Optional: Create a method to create a User object from a JSON String
  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));
}
