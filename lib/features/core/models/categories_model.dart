import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardCategoriesModel {
  final String? id;
  final String image;
  final String name;
  //final VoidCallback? onPress;

  DashboardCategoriesModel({
    this.id,
    required this.image,
    required this.name,
    //this.onPress
  });

  toJson() {
    return {
      'image': image,
      'name': name,
    };
  }

  factory DashboardCategoriesModel.formSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DashboardCategoriesModel(
      id: document.id,
      image: data['image'],
      name: data['name'],
    );
  }
/*
  static List<DashboardCategoriesModel> list = [
    DashboardCategoriesModel('JS', 'JavaScript'),
    DashboardCategoriesModel('F', 'Flutter'),
    DashboardCategoriesModel('H', 'HTML', null)
  ];*/
}
