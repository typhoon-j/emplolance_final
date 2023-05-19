import 'dart:developer';

import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:emplolance/features/messaging/controllers/chat_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../widgets/user_data_widget.dart';
import '../widgets/user_image_widget.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final listController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Conversaciones',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tus Conversaciones',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              //height: 100,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  FutureBuilder(
                      future:
                          listController.getUserChats((user?.uid).toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () async {
                                  if (user?.uid !=
                                      snapshot.data![index].userId1) {
                                    var userFutureData = await listController
                                        .getUserSelectedData(
                                            snapshot.data![index].userId1);

                                    Get.to(() => ChatRoomScreen(
                                          chatRoomId:
                                              snapshot.data![index].chatId,
                                          userData: userFutureData,
                                        ));
                                  } else {
                                    var userFutureData = await listController
                                        .getUserSelectedData(
                                            snapshot.data![index].userId2);

                                    Get.to(() => ChatRoomScreen(
                                          chatRoomId:
                                              snapshot.data![index].chatId,
                                          userData: userFutureData,
                                        ));
                                  }
                                },
                                child: SizedBox(
                                  width: 350,
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFF30475E)),
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //image del solicitante
                                              user?.uid !=
                                                      snapshot
                                                          .data![index].userId1
                                                  ? UserImageWidget(
                                                      userId: snapshot
                                                          .data![index].userId1,
                                                    )
                                                  : UserImageWidget(
                                                      userId: snapshot
                                                          .data![index].userId2,
                                                    ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: SizedBox(
                                                  height: 55,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //nombre del usuario solicitado
                                                      user?.uid !=
                                                              snapshot
                                                                  .data![index]
                                                                  .userId1
                                                          ? UserDatatWidget(
                                                              userId: snapshot
                                                                  .data![index]
                                                                  .userId1,
                                                            )
                                                          : UserDatatWidget(
                                                              userId: snapshot
                                                                  .data![index]
                                                                  .userId2,
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  goToChat(String userId) {}
}
