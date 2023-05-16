import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String photo;
  final String password;
  final String description;
  final String? userId;

  const UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.photo,
    required this.password,
    required this.description,
    required this.userId,
  });

  toJson() {
    return {
      'fullname': fullName,
      'email': email,
      'photo': photo,
      'password': password,
      'description': description,
      'userId': userId,
    };
  }

  factory UserModel.formSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      fullName: data['fullname'],
      email: data['email'],
      photo: data['photo'],
      password: data['password'],
      description: data['description'],
      userId: data['userId'],
    );
  }

  static List<UserModel> users = [
    const UserModel(
        fullName: 'fullName',
        email: 'email',
        photo: 'photo',
        password: 'password',
        description: 'description',
        userId: 'userId')
  ];
}
