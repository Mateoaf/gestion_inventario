import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final int stock;
  final double price;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.price,
    required this.category,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] as String,
      description: data['description'] as String,
      stock: (data['stock'] ?? 0) as int,
      price: (data['price'] is int) ? (data['price'] as int).toDouble() : data['price'] as double,
      category: data['category'] ?? 'Sin categoría',
    );
  }
}
