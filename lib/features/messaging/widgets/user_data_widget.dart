import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../authentication/models/user_model.dart';
import '../../core/controllers/request_controller.dart';

class UserDatatWidget extends StatelessWidget {
  UserDatatWidget({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;
  final controller = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getConsumerData(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            UserModel userData = snapshot.data as UserModel;
            return Text(
              userData.fullName,
              style: Theme.of(context).textTheme.headline4,
              overflow: TextOverflow.ellipsis,
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
