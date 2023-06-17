import 'dart:developer';

import 'package:emplolance/features/core/controllers/request_notification_controller.dart';

import '../../../../constants/colors.dart';
import '../../controllers/product_controller.dart';
import 'package:emplolance/features/core/controllers/request_controller.dart';
import '../../models/request_model.dart';
import 'package:emplolance/features/core/repository/request_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../constants/sizes.dart';
import '../../models/product_model.dart';

class RequestProductScreen extends StatelessWidget {
  RequestProductScreen(
      {required this.productId,
      required this.consumerUserId,
      required this.publisherUserId,
      super.key});

  final String productId;
  final String consumerUserId;
  final String publisherUserId;

  final requestController = Get.put(RequestController());
  RequestRepository database = RequestRepository();
  final controller = Get.put(ProductController());
  final notification = Get.put(RequestNotificationController());

  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Solicitar anuncio',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(tDefaultSize),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: controller.getProductData(productId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    ProductModel productData = snapshot.data as ProductModel;
                    requestController.newRequest.update(
                        'consumerId', (_) => consumerUserId,
                        ifAbsent: () => consumerUserId);
                    requestController.newRequest.update(
                        'publisherId', (_) => publisherUserId,
                        ifAbsent: () => publisherUserId);
                    requestController.newRequest.update(
                        'productId', (_) => productId,
                        ifAbsent: () => productId);
                    requestController.newRequest.update(
                        'requestId', (_) => uuid.v1(),
                        ifAbsent: () => uuid.v1());
                    requestController.newRequest
                        .update('isPending', (_) => true, ifAbsent: () => true);
                    requestController.newRequest.update(
                        'isAccepted', (_) => false,
                        ifAbsent: () => false);
                    requestController.newRequest.update(
                        'isCanceled', (_) => false,
                        ifAbsent: () => false);
                    requestController.newRequest.update(
                        'isInProgress', (_) => false,
                        ifAbsent: () => false);
                    requestController.newRequest.update(
                        'isFinished', (_) => false,
                        ifAbsent: () => false);
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Anuncio que solicitara',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            width: 320,
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10, top: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: tCardBgColor),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            productData.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.apply(color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Flexible(
                                          child: ClipOval(
                                            //borderRadius: BorderRadius.circular(100),
                                            child: Image(
                                              image: NetworkImage(
                                                  productData.imageUrl),
                                              height: 110,
                                              width: 110,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: tDashboardCardPadding,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Claificacion: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.apply(color: Colors.black),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Precio: ${productData.price}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.apply(color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Cuentele al autor del anuncio que espera conseguir con el servicio: ',
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildTextFormField(
                            'Descripcion', 'description', requestController),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              log(requestController.newRequest['consumerId']);
                              log(requestController.newRequest['publisherId']);
                              log(requestController.newRequest['requestId']);
                              log((requestController.newRequest['isPending'])
                                  .toString());
                              log((requestController.newRequest['isAccepted'])
                                  .toString());
                              log((requestController.newRequest['isCanceled'])
                                  .toString());
                              log((requestController.newRequest['isInProgress'])
                                  .toString());
                              log((requestController.newRequest['isFinished'])
                                  .toString());

                              log(requestController.newRequest['description']);
                              database.addRequest(
                                RequestModel(
                                  consumerId: requestController
                                      .newRequest['consumerId'],
                                  publisherId: requestController
                                      .newRequest['publisherId'],
                                  productId:
                                      requestController.newRequest['productId'],
                                  requestId:
                                      requestController.newRequest['requestId'],
                                  description: requestController
                                      .newRequest['description'],
                                  isPending:
                                      requestController.newRequest['isPending'],
                                  isAccepted: requestController
                                      .newRequest['isAccepted'],
                                  isCancelled: requestController
                                      .newRequest['isCanceled'],
                                  isFinished: requestController
                                      .newRequest['isFinished'],
                                  isInProgress: requestController
                                      .newRequest['isInProgress'],
                                ),
                              );
                              notification.sendPushNotification(
                                  publisherUserId, productId);
                              Get.back();
                            },
                            child: Text(
                              'Solicitar',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.apply(color: tSecondaryColor),
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
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(
      String label, String name, RequestController requestController) {
    return TextFormField(
      decoration: InputDecoration(label: Text(label)),
      onChanged: (value) {
        requestController.newRequest
            .update(name, (_) => value, ifAbsent: () => value);
      },
    );
  }
}
