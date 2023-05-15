import 'dart:developer';

import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/features/core/controllers/request_controller.dart';
import 'package:emplolance/features/core/models/request_model.dart';
import 'package:emplolance/features/core/widgets/requests/price_product_wdget.dart';
import 'package:emplolance/features/core/widgets/requests/product_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../widgets/products/UserDataProduct.dart';
import '../../widgets/top_courses.dart';
import '../chat_screen.dart';

class RequestDetailsScreen extends StatelessWidget {
  RequestDetailsScreen({
    Key? key,
    required this.requestId,
  }) : super(key: key);

  final controller = Get.put(RequestController());

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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        image:
                            AssetImage('assets/images/profile/user_image.jpg'),
                        alignment: Alignment.center,
                        height: 250,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
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
                              SizedBox(
                                height: 10,
                              ),
                              requestData.isPending == true
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
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
                                            onPressed: () => Get.back(),
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
                                  : const SizedBox()

                              /* SizedBox(
                                      width: double.infinity,
                                      child: Container(
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF17181C),
                                        ),
                                        child: Container(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
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
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Rechazar',
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
                                          ],
                                        ),
                                      ),
                                    ),*/
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
