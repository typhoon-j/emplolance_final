import 'package:flutter/material.dart';

class DashboardTopCoursesModel {
  final String title;
  final String heading;
  final String subHeading;
  final String image;
  final VoidCallback? onPress;

  DashboardTopCoursesModel(
      this.title, this.heading, this.subHeading, this.image, this.onPress);

  static List<DashboardTopCoursesModel> list = [
    DashboardTopCoursesModel('Desarrollo de Software', '5', 'Bs.999',
        'assets/images/profile/blank_profile.png', null),
    DashboardTopCoursesModel('Creacion de temas musicales', '4.5', 'Bs.450',
        'assets/images/dashboard/arquitectura.png', null),
    DashboardTopCoursesModel('H', 'HTML', '8 lessons',
        'assets/images/dashboard/ingenieria.png', null)
  ];
}
