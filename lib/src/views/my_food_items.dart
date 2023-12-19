import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/food_item_provider.dart';

class MyFoodItemList extends ConsumerWidget {
  const MyFoodItemList({super.key});

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
