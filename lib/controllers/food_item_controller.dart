import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/food_item.dart';

class FoodItemController extends StateNotifier<List<FoodItem>> {
  final SupabaseClient _supabaseClient;

  FoodItemController(this._supabaseClient) : super([]);

  Future<void> fetchItems() async {
    final response =
        await _supabaseClient.from('food_items').select().execute();

    if (response.data != null) {
      final List<FoodItem> items =
          (response.data as List).map((e) => FoodItem.fromJson(e)).toList();
      state = items; // Update the state with fetched items
    } else {
      throw Exception('Error fetching food items: something went wrong');
    }
  }

  Future<void> addItem(FoodItem item) async {
    await _supabaseClient
        .from('food_items')
        .insert(item.toJson())
        .execute()
        .onError((error, stackTrace) =>
            throw Exception('Error adding food item: ${error?.toString()}'));
    // Refresh the list after adding
    fetchItems().catchError((error) =>
        throw Exception('Error adding food item: ${error?.toString()}'));
  }

  Future<void> updateItem(String id, FoodItem updatedItem) async {
    await _supabaseClient
        .from('food_items')
        .update(updatedItem.toJson())
        .eq('id', id)
        .execute()
        .onError((error, stackTrace) =>
            throw Exception('Error updating food item: ${error?.toString()}'));
// Refresh the list after updating
    fetchItems().catchError(
        (error) => throw Exception('Error fetching: ${error?.toString()}'));
  }

  Future<void> deleteItem(String id) async {
    await _supabaseClient
        .from('food_items')
        .delete()
        .eq('id', id)
        .execute()
        .onError((error, stackTrace) =>
            throw Exception('Error deleting food item: ${error?.toString()}'));
// Refresh the list after deleting
    fetchItems().catchError(
        (error) => throw Exception('Error fetching: ${error?.toString()}'));
  }
}
