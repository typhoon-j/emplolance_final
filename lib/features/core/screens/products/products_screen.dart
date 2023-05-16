import 'dart:developer';
import 'package:emplolance/features/core/controllers/product_controller.dart';
import 'package:emplolance/features/core/screens/products/add_products.dart';
import 'package:emplolance/features/core/screens/products/product_selected_screen.dart';
import 'package:emplolance/features/core/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listController = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Tus Anuncios',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text(              'Tus productos',              style: Theme.of(context).textTheme.headline4,            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listController.products.length,
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
                                            listController.products[index].name,
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
                                              image: NetworkImage(listController
                                                  .products[index].imageUrl),
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
                                              Get.to(() =>
                                                  ProductSelectedScreen(
                                                    productId: (listController
                                                            .products[index]
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
                                              'Precio: ${listController.products[index].price}',
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
