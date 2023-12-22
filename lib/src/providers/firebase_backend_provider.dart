import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/backends/firebase_user_backend.dart';
import '../services/backends/firestore_food_backend.dart';

final firebaseBackendProvider = Provider<FirebaseBackend>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  return FirebaseBackend(firebaseAuth, firestore);
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firestoreFoodItemBackendProvider =
    Provider<FirestoreFoodItemBackend>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return FirestoreFoodItemBackend(firestore);
});
