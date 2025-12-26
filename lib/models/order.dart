// lib/models/order.dart
class Order {
  String item;
  String itemName;
  double price;
  String currency;
  int quantity;

  Order({
    required this.item,
    required this.itemName,
    required this.price,
    required this.currency,
    required this.quantity,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      item: json['Item'] ?? '',
      itemName: json['ItemName'] ?? '',
      price: (json['Price'] is int)
          ? (json['Price'] as int).toDouble()
          : (json['Price'] as double),
      currency: json['Currency'] ?? 'USD',
      quantity: json['Quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Item': item,
      'ItemName': itemName,
      'Price': price,
      'Currency': currency,
      'Quantity': quantity,
    };
  }

  @override
  String toString() {
    return '${item.padRight(10)} | ${itemName.padRight(20)} | ${price.toString().padRight(10)} | ${currency.padRight(5)} | $quantity';
  }
}