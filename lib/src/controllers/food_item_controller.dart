import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import '../models/food_item.dart';
import '../state/food_item_state.dart';

class FoodItemController extends StateNotifier<FoodItemState> {
  final FirebaseFirestore _firestore;

  FoodItemController(this._firestore) : super(const FoodItemState());

  Future<void> fetchItems() async {
    state = state.copyWith(status: FoodItemStatus.loading);
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('food_items').get();
      final List<FoodItem> items = snapshot.docs
          .map((doc) => FoodItem.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      state = state.copyWith(status: FoodItemStatus.success, items: items);
    } catch (e) {
      state = state.copyWith(
          status: FoodItemStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> addItem(FoodItem item) async {
    state = state.copyWith(status: FoodItemStatus.loading);
    try {
      await _firestore.collection('food_items').add(item.toJson());
      await fetchItems();
    } catch (e) {
      state = state.copyWith(
          status: FoodItemStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> updateItem(String id, FoodItem updatedItem) async {
    state = state.copyWith(status: FoodItemStatus.loading);
    try {
      await _firestore
          .collection('food_items')
          .doc(id)
          .update(updatedItem.toJson());
      await fetchItems();
    } catch (e) {
      state = state.copyWith(
          status: FoodItemStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> deleteItem(String id) async {
    state = state.copyWith(status: FoodItemStatus.loading);
    try {
      await _firestore.collection('food_items').doc(id).delete();
      await fetchItems();
    } catch (e) {
      state = state.copyWith(
          status: FoodItemStatus.error, errorMessage: e.toString());
    }
  }
}
