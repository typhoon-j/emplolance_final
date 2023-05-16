import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../authentication/models/user_model.dart';
import '../../controllers/request_controller.dart';

class RaterNameWidget extends StatelessWidget {
  RaterNameWidget({
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
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.apply(color: Colors.black),
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
