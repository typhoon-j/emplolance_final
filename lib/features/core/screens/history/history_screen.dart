import 'dart:developer';
import 'package:emplolance/features/core/controllers/product_controller.dart';
import 'package:emplolance/features/core/controllers/request_controller.dart';
import 'package:emplolance/features/core/screens/products/add_products.dart';
import 'package:emplolance/features/core/screens/products/product_selected_screen.dart';
import 'package:emplolance/features/core/screens/requests/request_details_screen.dart';
import 'package:emplolance/features/core/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rounded_background_text/rounded_background_text.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../widgets/requests/consumer_image_widget.dart';
import '../../widgets/requests/product_data_widget.dart';
import '../../widgets/requests/user_consumer_data_widget.dart';
import 'history_details_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listController = Get.put(RequestController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Solicitudes',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tus solicitudes',
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
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listController.history.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.to(() => HistoryDetailsScreen(
                              requestId:
                                  listController.history[index].requestId));
                        },
                        child: SizedBox(
                          width: 350,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, top: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF30475E)),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //image del solicitante
                                      ConsumerImageWidget(
                                        userId: listController
                                            .history[index].consumerId,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        height: 75,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //nombre del anuncio solicitado
                                            ProductDataFromRequestWidget(
                                                productId: listController
                                                    .history[index].productId),
                                            //nombre del solicitante
                                            ConsumerUserDataWidget(
                                                userId: listController
                                                    .history[index].consumerId),
                                            listController.history[index]
                                                        .isPending ==
                                                    true
                                                ? RoundedBackgroundText(
                                                    'Pendiente',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        ?.apply(
                                                            color:
                                                                tSecondaryColor),
                                                    backgroundColor:
                                                        tPrimaryColor,
                                                    outerRadius: 90.0,
                                                  )
                                                : const SizedBox(),
                                            listController.history[index]
                                                        .isAccepted ==
                                                    true
                                                ? RoundedBackgroundText(
                                                    'Aceptado',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        ?.apply(
                                                            color: tWhiteColor),
                                                    backgroundColor:
                                                        const Color(0xFF064663),
                                                    outerRadius: 90.0,
                                                  )
                                                : const SizedBox(),
                                            listController.history[index]
                                                        .isCancelled ==
                                                    true
                                                ? RoundedBackgroundText(
                                                    'Rechazado',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        ?.apply(
                                                            color: tWhiteColor),
                                                    backgroundColor:
                                                        const Color(0xFFDA0037),
                                                    outerRadius: 90.0,
                                                  )
                                                : const SizedBox(),
                                            listController.history[index]
                                                        .isInProgress ==
                                                    true
                                                ? RoundedBackgroundText(
                                                    'En Progreso',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        ?.apply(
                                                            color: tWhiteColor),
                                                    backgroundColor:
                                                        const Color(0xFFEF6C00),
                                                    outerRadius: 90.0,
                                                  )
                                                : const SizedBox(),
                                            listController.history[index]
                                                        .isFinished ==
                                                    true
                                                ? RoundedBackgroundText(
                                                    'Completado',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        ?.apply(
                                                            color: tWhiteColor),
                                                    backgroundColor:
                                                        Colors.black,
                                                    outerRadius: 90.0,
                                                  )
                                                : const SizedBox(),
                                          ],
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
