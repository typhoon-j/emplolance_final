import 'package:emplolance/features/core/controllers/rating_controller.dart';
import 'package:emplolance/features/core/screens/comments/product_comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../models/rating_model.dart';
import '../ratings/rater_image_widget.dart';
import '../ratings/rater_name_widget.dart';

class RatingsFromProductSelectedWidget extends StatelessWidget {
  const RatingsFromProductSelectedWidget({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    final listController = Get.put(RatingController());
    return SizedBox(
      height: 200,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Expanded(
            child: FutureBuilder<List<RatingModel>>(
              future: listController.getRatingSelectedProduct(productId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => GestureDetector(
                        //  onTap: listController.products[index].onPress,
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
                                          '"${snapshot.data![index].comment}"',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              ?.apply(color: Colors.black),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      RaterImageWidget(
                                        userId: snapshot.data![index].raterId,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder()),
                                          onPressed: () {
                                            Get.to(() => ProductCommentScreen(
                                                  ratingData:
                                                      snapshot.data![index],
                                                  productId: productId,
                                                ));
                                          },
                                          child: const Icon(Icons.info)),
                                      const SizedBox(
                                        width: tDashboardCardPadding,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Claificacion: ${snapshot.data![index].rating}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.apply(color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          RaterNameWidget(
                                              userId: snapshot
                                                  .data![index].raterId),
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
          ),
        ],
      ),
    );
  }
}
