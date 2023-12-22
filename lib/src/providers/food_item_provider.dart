import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/food_item_controller.dart';
import '../state/food_item_state.dart';
import 'firebase_backend_provider.dart';

final foodItemControllerProvider =
    StateNotifierProvider<FoodItemController, FoodItemState>((ref) {
  final backend = ref.watch(firestoreFoodItemBackendProvider);
  return FoodItemController(backend);
});
