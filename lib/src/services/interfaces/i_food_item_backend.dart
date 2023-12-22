import '../../models/food_item.dart';

abstract class IFoodItemBackend {
  Future<List<FoodItem>> fetchItems();
  Future<void> addItem(FoodItem item);
  Future<void> updateItem(String id, FoodItem updatedItem);
  Future<void> deleteItem(String id);
}
