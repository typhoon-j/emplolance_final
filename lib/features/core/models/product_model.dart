import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String? id;
  final String name;
  final String userId;
  final String productId;
  final String category;
  final String imageUrl;
  final String description;
  final double price;
  final bool active;

  const ProductModel({
    this.id,
    required this.name,
    required this.userId,
    required this.productId,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.active,
  });

  ProductModel copyWith({
    String? name,
    String? userId,
    String? productId,
    String? category,
    String? imageUrl,
    String? description,
    double? price,
    bool? active,
  }) {
    return ProductModel(
      name: name ?? this.name,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userId': userId,
      'productId': productId,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'active': active,
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data()! as Map<String, dynamic>;
    return ProductModel(
      id: snap.id,
      name: snap['name'] as String,
      userId: snap['userId'] as String,
      productId: snap['productId'] as String,
      category: snap['category'] as String,
      imageUrl: snap['imageUrl'] as String,
      description: snap['description'] as String,
      price: snap['price'] as double,
      active: snap['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      userId,
      productId,
      category,
      imageUrl,
      description,
      price,
      active,
    ];
  }

  static List<ProductModel> products = [
    const ProductModel(
        name: 'Desarrollo de Software',
        userId: 'fkldjlfksd',
        productId: 'dsdsadadkjlas',
        category: 'Programacion',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/emplolance-1c684.appspot.com/o/categories_images%2Fprogramacion.png?alt=media&token=ef7f9f89-8454-4d29-a0c9-7d6b3ebda52f',
        description: 'Una descripcion',
        price: 95.1,
        active: true)
  ];

  static List<ProductModel> allProducts = [
    const ProductModel(
        name: 'Desarrollo de Software',
        userId: 'fkldjlfksd',
        productId: 'dsdsadadkjlas',
        category: 'Programacion',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/emplolance-1c684.appspot.com/o/categories_images%2Fprogramacion.png?alt=media&token=ef7f9f89-8454-4d29-a0c9-7d6b3ebda52f',
        description: 'Una descripcion',
        price: 95.1,
        active: true)
  ];
}
