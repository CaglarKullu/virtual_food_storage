import 'package:flutter/foundation.dart';

import '../models/food_item.dart';

enum FoodItemStatus { initial, loading, success, error }

@immutable
class FoodItemState {
  final FoodItemStatus status;
  final List<FoodItem>? items;
  final String? errorMessage;

  const FoodItemState(
      {this.status = FoodItemStatus.initial, this.items, this.errorMessage});

  FoodItemState copyWith(
      {FoodItemStatus? status, List<FoodItem>? items, String? errorMessage}) {
    return FoodItemState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
