import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/food_item.dart';
import '../interfaces/i_food_item_backend.dart';

class FirestoreFoodItemBackend implements IFoodItemBackend {
  final FirebaseFirestore _firestore;

  FirestoreFoodItemBackend(this._firestore);

  @override
  Future<List<FoodItem>> fetchItems() async {
    final QuerySnapshot snapshot =
        await _firestore.collection('food_items').get();
    return snapshot.docs
        .map((doc) => FoodItem.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addItem(FoodItem item) async {
    await _firestore.collection('food_items').add(item.toJson());
  }

  @override
  Future<void> updateItem(String id, FoodItem updatedItem) async {
    await _firestore
        .collection('food_items')
        .doc(id)
        .update(updatedItem.toJson());
  }

  @override
  Future<void> deleteItem(String id) async {
    await _firestore.collection('food_items').doc(id).delete();
  }
}
