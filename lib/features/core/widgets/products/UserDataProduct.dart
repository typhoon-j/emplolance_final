import 'dart:developer';

import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class UserDataProductWidget extends StatelessWidget {
  UserDataProductWidget({
    required this.userId,
    Key? key,
  }) : super(key: key);

  final controller = Get.put(ProductController());
  final String userId;

  @override
  Widget build(BuildContext context) {
    //log('UserId: ${userId}');
    return FutureBuilder(
      future: controller.getUserData(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            UserModel userData = snapshot.data as UserModel;
            return Row(
              children: [
                ClipOval(
                    //borderRadius: BorderRadius.circular(100),
                    child: Image(
                  image: NetworkImage(userData.photo),
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                )),
                Text(
                  '  ${userData.fullName}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Text('Something went wrong');
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
