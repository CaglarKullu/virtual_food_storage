class FoodItem {
  final String id;
  final String name;
  final int quantity;
  final DateTime expirationDate;
  final String category;

  FoodItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.expirationDate,
    required this.category,
  });

  // Factory method for creating a FoodItem from a map (deserialization)
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      expirationDate: DateTime.parse(json['expirationDate']),
      category: json['category'],
    );
  }

  // Method to convert FoodItem instance to a map (serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'expirationDate': expirationDate.toIso8601String(),
      'category': category,
    };
  }
}
