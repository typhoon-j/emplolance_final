import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../authentication/controllers/profile_controller.dart';
import '../../authentication/models/user_model.dart';

class AppBarImageWidget extends StatelessWidget {
  const AppBarImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return FutureBuilder(
      future: controller.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            UserModel userData = snapshot.data as UserModel;
            return Image(
              image: NetworkImage(userData.photo),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Text('Something went worng');
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
