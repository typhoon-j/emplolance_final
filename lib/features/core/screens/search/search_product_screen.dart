import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/features/core/controllers/search_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../widgets/appbar.dart';
import '../products/product_selected_screen.dart';
import '../ratings/product_rating_dashboard_widget.dart';
import '../ratings/product_rating_widget.dart';
import '../user_selected_screen.dart';

class SearchProductScreen extends StatelessWidget {
  const SearchProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Arquitectura',
      'Arte',
      'Diseño',
      'Escritura',
      'Fotografía',
      'Ingeniería',
      'Música',
      'Programación',
      'Video'
    ];

    String _selectedCategory = '';

    final controller = Get.put(SearchUserController());

    return Scaffold(
      appBar: DashboardAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              DropdownButtonFormField(
                  iconSize: 20,
                  decoration: const InputDecoration(hintText: 'Categoria'),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                        value: category, child: Text(category));
                  }).toList(),
                  onChanged: (value) {
                    _selectedCategory = value.toString();
                  }),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) =>
                    controller.searchProduct(value, _selectedCategory),
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  contentPadding: EdgeInsets.all(12.0),
                  fillColor: Colors.transparent,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(),
              const SizedBox(
                height: 10,
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
                          itemCount: controller.products.length,
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
                                              controller.products[index].name,
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
                                                image: NetworkImage(controller
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
                                                      productId: (controller
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
                                                      productId: controller
                                                          .products[index]
                                                          .productId),
                                                ],
                                              ),
                                              Text(
                                                'Precio: ${controller.products[index].price}',
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
