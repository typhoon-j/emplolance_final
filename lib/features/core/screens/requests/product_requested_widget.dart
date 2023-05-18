import 'package:emplolance/features/core/screens/products/product_selected_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';
import '../ratings/product_rating_dashboard_widget.dart';

class ProductRequestedWidget extends StatelessWidget {
  ProductRequestedWidget({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return SizedBox(
      height: 200,
      child: FutureBuilder(
          future: controller.getProductData(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                ProductModel productData = snapshot.data as ProductModel;
                return SizedBox(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    image: NetworkImage(productData.imageUrl),
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
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder()),
                                  onPressed: () {
                                    Get.to(() => ProductSelectedScreen(
                                          productId: (productData.productId)
                                              .toString(),
                                        ));
                                  },
                                  child: const Icon(Icons.info)),
                              const SizedBox(
                                width: tDashboardCardPadding,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
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
                                      ProductRatingDashboardWidget(
                                        productId: productData.productId,
                                      )
                                    ],
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
