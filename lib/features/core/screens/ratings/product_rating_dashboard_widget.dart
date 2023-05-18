import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/rating_controller.dart';
import '../../models/rating_model.dart';

class ProductRatingDashboardWidget extends StatelessWidget {
  ProductRatingDashboardWidget({
    required this.productId,
    Key? key,
  }) : super(key: key);

  String productId;

  @override
  Widget build(BuildContext context) {
    final listController = Get.put(RatingController());
    double _cont = 0;
    return Column(
      children: [
        FutureBuilder<List<RatingModel>>(
          future: listController.getRatingSelectedProduct(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                for (var i = 0; i < snapshot.data!.length; i++) {
                  _cont = _cont + snapshot.data![i].rating;
                }
                double avg = _cont / snapshot.data!.length;
                log(avg.toString());

                return _cont != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(avg.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.apply(color: Colors.black)),
                          const Icon(
                            Icons.star_outlined,
                            color: Colors.black,
                            size: 25,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('0',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.apply(color: Colors.black)),
                          const Icon(
                            Icons.star_outlined,
                            color: Colors.black,
                            size: 25,
                          ),
                        ],
                      );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
