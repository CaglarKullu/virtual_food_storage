import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/food_item_provider.dart';

class MyFoodItemList extends ConsumerWidget {
  const MyFoodItemList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodItems = ref.watch(foodItemControllerProvider);

    return ListView.builder(
      itemCount: foodItems.items?.length,
      itemBuilder: (context, index) {
        final item = foodItems.items?[index];
        return ListTile(
          title: Text(item?.name ?? 'no item'),
          // other UI elements
        );
      },
    );
  }
}
