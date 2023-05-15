import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../authentication/models/user_model.dart';
import '../../controllers/request_controller.dart';

class ConsumerImageWidget extends StatelessWidget {
  ConsumerImageWidget({
    required this.userId,
    Key? key,
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
            return Flexible(
              child: ClipOval(
                //borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: NetworkImage(userData.photo),
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
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
