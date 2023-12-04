import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_food_storage/providers/food_item_provider.dart';

class MyFoodItemList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodItems = ref.watch(foodItemControllerProvider);

    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        final item = foodItems[index];
        return ListTile(
          title: Text(item.name),
          // other UI elements
        );
      },
    );
  }
}
