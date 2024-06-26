import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_food_storage/src/providers/firebase_backend_provider.dart';
import '../controllers/user_controller.dart';
import '../state/user_state.dart';

final userProvider = StateNotifierProvider<UserController, UserState>((ref) {
  final backend = ref.watch(firebaseBackendProvider);
  return UserController(backend);
});
