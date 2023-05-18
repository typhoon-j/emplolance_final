import 'dart:developer';
import 'package:emplolance/features/core/controllers/categories%20_controller.dart';
import 'package:emplolance/features/core/controllers/product_controller.dart';
import 'package:emplolance/features/core/models/categories_model.dart';
import 'package:emplolance/features/core/screens/products/add_products.dart';
import 'package:emplolance/features/core/screens/products/product_selected_screen.dart';
import 'package:emplolance/features/core/screens/ratings/product_rating_dashboard_widget.dart';
import 'package:emplolance/features/core/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({required this.category, Key? key}) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    final listController = Get.put(CategoriesController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Anuncios por categoria',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                  future: listController.getCategoryProductsData(category),
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
                                padding:
                                    const EdgeInsets.only(right: 10, top: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: tCardBgColor),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              snapshot.data![index].name,
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
                                                image: NetworkImage(snapshot
                                                    .data![index].imageUrl),
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
                                                Get.to(
                                                    () => ProductSelectedScreen(
                                                          productId: (snapshot
                                                                  .data![index]
                                                                  .productId)
                                                              .toString(),
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
                                              Row(
                                                children: [
                                                  Text(
                                                    'Claificacion: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        ?.apply(
                                                            color:
                                                                Colors.black),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  ProductRatingDashboardWidget(
                                                    productId: snapshot
                                                        .data![index].productId,
                                                  )
                                                ],
                                              ),
                                              Text(
                                                'Precio: ${snapshot.data![index].price}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    ?.apply(
                                                        color: Colors.black),
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
            )
          ],
        ),
      ),
    );
  }
}
