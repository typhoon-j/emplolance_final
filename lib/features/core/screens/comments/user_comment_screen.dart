import 'dart:developer';

import 'package:emplolance/features/authentication/controllers/profile_controller.dart';
import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:emplolance/features/core/controllers/rating_controller.dart';
import 'package:emplolance/features/core/models/rating_model.dart';
import 'package:emplolance/features/core/screens/requests/product_requested_widget.dart';
import 'package:emplolance/features/messaging/controllers/chat_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/products/UserDataProduct.dart';
import '../ratings/user_rating_widget.dart';

class UserCommentScreen extends StatelessWidget {
  UserCommentScreen({
    Key? key,
    required this.ratingData,
    required this.userId,
  }) : super(key: key);

  final controller = Get.put(ProfileController());
  final ratingController = Get.put(RatingController());
  final chatController = Get.put(ChatController());
  final User? user = FirebaseAuth.instance.currentUser;
  var uuid = Uuid();

  final RatingModel ratingData;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Detalles de la calificacion',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: FutureBuilder(
          future: controller.getUserSelectedData(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel userData = snapshot.data as UserModel;
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Usuario Calificado',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipOval(
                              //borderRadius: BorderRadius.circular(100),
                              child: Image(
                            image: NetworkImage(userData.photo),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userData.fullName,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    UserRatingWidget(
                      userId: (userData.userId).toString(),
                    ),
                    //Text('5 ', //userData.email, style: Theme.of(context).textTheme.bodyText2, ),
                    const SizedBox(
                      height: 20,
                    ),
                    DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFF2C2D32),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent malesuada laoreet urna, a ornare neque pellentesque ut. Integer vehicula aliquam justo elementum mollis.',
                            userData.description,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF222831),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Informacion de Calificacion',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Calificado por ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    Text(ratingData.rating.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                    const Icon(
                                      Icons.star_outlined,
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ),
                              UserDataProductWidget(userId: ratingData.raterId),
                              const SizedBox(
                                height: 10,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Color(0xFF2C2D32),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent malesuada laoreet urna, a ornare neque pellentesque ut. Integer vehicula aliquam justo elementum mollis.',
                                    ratingData.comment,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
          }),
    );
  }
}
