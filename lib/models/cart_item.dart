class CartItem {
  final String productId;
  int quantity;

  CartItem({required this.productId, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      CartItem(productId: json['productId'], quantity: json['quantity']);

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
  };
}
