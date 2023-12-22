import 'package:riverpod/riverpod.dart';
import '../models/food_item.dart';
import '../services/interfaces/i_food_item_backend.dart';
import '../state/food_item_state.dart';

class FoodItemController extends StateNotifier<FoodItemState> {
  final IFoodItemBackend _backend;

  FoodItemController(this._backend) : super(const FoodItemState());

  Future<void> fetchItems() async {
    state = state.copyWith(status: FoodItemStatus.loading);
    try {
      final items = await _backend.fetchItems();
      state = state.copyWith(status: FoodItemStatus.success, items: items);
    } catch (e) {
      state = state.copyWith(
          status: FoodItemStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> addItem(FoodItem item) async {
    state = state.copyWith(status: FoodItemStatus.loading);
    try {
      await _backend.addItem(item);
      await fetchItems();
    } catch (e) {
      state = state.copyWith(
          status: FoodItemStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> updateItem(String id, FoodItem updatedItem) async {
    state = state.copyWith(status: FoodItemStatus.loading);
    try {
      await _backend.updateItem(id, updatedItem);
      await fetchItems();
    } catch (e) {
      state = state.copyWith(
          status: FoodItemStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> deleteItem(String id) async {
    state = state.copyWith(status: FoodItemStatus.loading);
    try {
      await _backend.deleteItem(id);
      await fetchItems();
    } catch (e) {
      state = state.copyWith(
          status: FoodItemStatus.error, errorMessage: e.toString());
    }
  }
}
