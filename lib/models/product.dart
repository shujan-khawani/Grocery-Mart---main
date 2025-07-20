class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String description;
  final String category;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    image: json['image'],
    description: json['description'],
    category: json['category'],
    stock: json['stock'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'image': image,
    'description': description,
    'category': category,
    'stock': stock,
  };
}
