import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/food_item.dart';
import '../controllers/food_item_controller.dart';
import 'supabase_client_provider.dart';

final foodItemControllerProvider =
    StateNotifierProvider<FoodItemController, List<FoodItem>>((ref) {
  return FoodItemController(ref.read(subabaseClientProvider));
});