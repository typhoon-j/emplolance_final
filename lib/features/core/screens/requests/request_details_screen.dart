import 'dart:developer';

import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/features/core/controllers/request_controller.dart';
import 'package:emplolance/features/core/controllers/rating_controller.dart';
import 'package:emplolance/features/core/models/request_model.dart';
import 'package:emplolance/features/core/screens/requests/product_requested_widget.dart';
import 'package:emplolance/features/core/widgets/requests/price_product_wdget.dart';
import 'package:emplolance/features/core/widgets/requests/product_data_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../widgets/products/UserDataProduct.dart';
import '../../widgets/top_courses.dart';
import '../chat_screen.dart';

class RequestDetailsScreen extends StatelessWidget {
  RequestDetailsScreen({
    Key? key,
    required this.requestId,
  }) : super(key: key);

  final controller = Get.put(RequestController());
  final ratingController = Get.put(RatingController());
  final User? user = FirebaseAuth.instance.currentUser;

  final String requestId;

  @override
  Widget build(BuildContext context) {
    log('RequestId: $requestId');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Detalles de la solicitud',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: FutureBuilder(
          future: controller.getRequestData(requestId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                RequestModel requestData = snapshot.data as RequestModel;
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Anuncio Solicitado',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ProductRequestedWidget(productId: requestData.productId),
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
                                        child: ProductDataFromRequestWidget(
                                            productId: requestData.productId)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Solicitado por ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    PriceProductWidget(
                                        productId: requestData.productId)
                                  ],
                                ),
                              ),
                              UserDataProductWidget(
                                  userId: requestData.consumerId),
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
                                    requestData.description,
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
                              requestData.isPending == true
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final requestAcceptData =
                                                  RequestModel(
                                                id: requestData.id,
                                                requestId:
                                                    requestData.requestId,
                                                consumerId:
                                                    requestData.consumerId,
                                                publisherId:
                                                    requestData.publisherId,
                                                productId:
                                                    requestData.productId,
                                                description:
                                                    requestData.description,
                                                isPending: false,
                                                isAccepted: true,
                                                isCancelled:
                                                    requestData.isCancelled,
                                                isFinished:
                                                    requestData.isFinished,
                                                isInProgress:
                                                    requestData.isInProgress,
                                              );
                                              await controller
                                                  .updateRequestData(
                                                      requestAcceptData);
                                              Get.to(() => const ChatScreen());
                                            },
                                            child: Text(
                                              'Aceptar',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.apply(
                                                      color: tSecondaryColor),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      tPrimaryColor),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final requestCancelData =
                                                  RequestModel(
                                                id: requestData.id,
                                                requestId:
                                                    requestData.requestId,
                                                consumerId:
                                                    requestData.consumerId,
                                                publisherId:
                                                    requestData.publisherId,
                                                productId:
                                                    requestData.productId,
                                                description:
                                                    requestData.description,
                                                isPending: false,
                                                isAccepted:
                                                    requestData.isAccepted,
                                                isCancelled: true,
                                                isFinished:
                                                    requestData.isFinished,
                                                isInProgress:
                                                    requestData.isInProgress,
                                              );
                                              await controller
                                                  .updateRequestData(
                                                      requestCancelData);
                                              Get.back();
                                            },
                                            child: Text(
                                              'Rechazar',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.apply(color: tWhiteColor),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              requestData.isAccepted == true
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final requestInProgressData =
                                                  RequestModel(
                                                id: requestData.id,
                                                requestId:
                                                    requestData.requestId,
                                                consumerId:
                                                    requestData.consumerId,
                                                publisherId:
                                                    requestData.publisherId,
                                                productId:
                                                    requestData.productId,
                                                description:
                                                    requestData.description,
                                                isPending:
                                                    requestData.isPending,
                                                isAccepted: false,
                                                isCancelled:
                                                    requestData.isCancelled,
                                                isFinished:
                                                    requestData.isFinished,
                                                isInProgress: true,
                                              );
                                              await controller
                                                  .updateRequestData(
                                                      requestInProgressData);
                                              Get.back();
                                            },
                                            child: Text(
                                              'Comenzar',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.apply(
                                                      color: tSecondaryColor),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      tPrimaryColor),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final requestCancelData =
                                                  RequestModel(
                                                id: requestData.id,
                                                requestId:
                                                    requestData.requestId,
                                                consumerId:
                                                    requestData.consumerId,
                                                publisherId:
                                                    requestData.publisherId,
                                                productId:
                                                    requestData.productId,
                                                description:
                                                    requestData.description,
                                                isPending:
                                                    requestData.isPending,
                                                isAccepted: false,
                                                isCancelled: true,
                                                isFinished:
                                                    requestData.isFinished,
                                                isInProgress:
                                                    requestData.isInProgress,
                                              );
                                              await controller
                                                  .updateRequestData(
                                                      requestCancelData);
                                              Get.back();
                                            },
                                            child: Text(
                                              'Rechazar',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.apply(color: tWhiteColor),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              requestData.isInProgress == true
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final requestFinishData =
                                                  RequestModel(
                                                id: requestData.id,
                                                requestId:
                                                    requestData.requestId,
                                                consumerId:
                                                    requestData.consumerId,
                                                publisherId:
                                                    requestData.publisherId,
                                                productId:
                                                    requestData.productId,
                                                description:
                                                    requestData.description,
                                                isPending:
                                                    requestData.isPending,
                                                isAccepted:
                                                    requestData.isAccepted,
                                                isCancelled:
                                                    requestData.isCancelled,
                                                isFinished: true,
                                                isInProgress: false,
                                              );
                                              await controller
                                                  .updateRequestData(
                                                      requestFinishData);
                                              Get.back();
                                            },
                                            child: Text(
                                              'Finalizar',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.apply(
                                                      color: tSecondaryColor),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      tPrimaryColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              requestData.isFinished == true
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              ratingController.showRatingDialog(
                                                  (user?.uid).toString(),
                                                  requestData.consumerId);
                                            },
                                            child: Text(
                                              'Calificar al usuario',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.apply(
                                                      color: tSecondaryColor),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      tPrimaryColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox()
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
