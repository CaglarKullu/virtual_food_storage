import '../models/food_item.dart';

enum FoodItemStateStatus { initial, loading, success, error }

class FoodItemState {
  final FoodItemStateStatus status;
  final List<FoodItem>? items;
  final String? errorMessage;

  FoodItemState(
      {this.status = FoodItemStateStatus.initial,
      this.items,
      this.errorMessage});

  FoodItemState copyWith(
      {FoodItemStateStatus? status,
      List<FoodItem>? items,
      String? errorMessage}) {
    return FoodItemState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
