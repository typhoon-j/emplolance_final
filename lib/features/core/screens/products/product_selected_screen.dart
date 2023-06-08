import 'dart:developer';

import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/features/core/controllers/product_controller.dart';
import 'package:emplolance/features/core/models/product_model.dart';
import 'package:emplolance/features/core/screens/products/update_product.dart';
import 'package:emplolance/features/core/widgets/products/ratings_from_product_selected_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/image_strings.dart';
import '../../widgets/products/UserDataProduct.dart';
import '../../widgets/top_products.dart';
import '../ratings/product_rating_widget.dart';
import '../requests/request_product_screen.dart';

class ProductSelectedScreen extends StatelessWidget {
  ProductSelectedScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final controller = Get.put(ProductController());

  final User? user = FirebaseAuth.instance.currentUser;
  final String productId;

  @override
  Widget build(BuildContext context) {
    log(productId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Detalles del Anuncio',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: FutureBuilder(
          future: controller.getProductData(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                ProductModel productData = snapshot.data as ProductModel;
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        image: NetworkImage(productData.imageUrl),
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
                                      child: Text(
                                        productData.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ),
                                    //extraer widget  pasar datos de calificacion
                                    ProductRatingWidget(
                                        productId: productData.productId),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Publicado por ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    Text(
                                      'Precio: Bs. ${productData.price}',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                              UserDataProductWidget(userId: productData.userId),
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
                                    productData.description,
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
                              productData.userId == user?.uid
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text.rich(
                                          TextSpan(
                                            text: 'Acciones disponibles: ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.to(() => UpdateProductScreen(
                                                  productData: productData,
                                                ));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amberAccent
                                                .withOpacity(0.1),
                                            elevation: 0,
                                            foregroundColor: Colors.amber,
                                            shape: const StadiumBorder(),
                                            side: BorderSide.none,
                                          ),
                                          child: const Text('Actualizar'),
                                        ),
                                        productData.active == true
                                            ? ElevatedButton(
                                                onPressed: () async {
                                                  final productAvailableData =
                                                      ProductModel(
                                                    id: productData.id,
                                                    name: productData.name,
                                                    category:
                                                        productData.category,
                                                    imageUrl:
                                                        productData.imageUrl,
                                                    description:
                                                        productData.description,
                                                    userId: productData.userId,
                                                    productId:
                                                        productData.productId,
                                                    price: productData.price,
                                                    active: false,
                                                  );
                                                  await controller
                                                      .updateProductAvailableData(
                                                          productAvailableData);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .redAccent
                                                      .withOpacity(0.1),
                                                  elevation: 0,
                                                  foregroundColor: Colors.red,
                                                  shape: const StadiumBorder(),
                                                  side: BorderSide.none,
                                                ),
                                                child: const Text('Desactivar'),
                                              )
                                            : ElevatedButton(
                                                onPressed: () async {
                                                  final productAvailableData =
                                                      ProductModel(
                                                    id: productData.id,
                                                    name: productData.name,
                                                    category:
                                                        productData.category,
                                                    imageUrl:
                                                        productData.imageUrl,
                                                    description:
                                                        productData.description,
                                                    userId: productData.userId,
                                                    productId:
                                                        productData.productId,
                                                    price: productData.price,
                                                    active: true,
                                                  );
                                                  await controller
                                                      .updateProductAvailableData(
                                                          productAvailableData);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .redAccent
                                                      .withOpacity(0.1),
                                                  elevation: 0,
                                                  foregroundColor: Colors.green,
                                                  shape: const StadiumBorder(),
                                                  side: BorderSide.none,
                                                ),
                                                child: const Text('Activar'),
                                              ),
                                      ],
                                    )
                                  // const SizedBox()
                                  : const SizedBox(
                                      height: 0.5,
                                    ),
                              productData.userId == user?.uid
                                  ? const SizedBox(
                                      height: 0.5,
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      child: Container(
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF17181C),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.to(() => RequestProductScreen(
                                                  productId:
                                                      productData.productId,
                                                  consumerUserId:
                                                      (user?.uid).toString(),
                                                  publisherUserId:
                                                      productData.userId,
                                                ));
                                          },
                                          child: Text(
                                            'Solicitar',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.apply(color: tSecondaryColor),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    tPrimaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Comentarios',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.apply(fontSizeFactor: 1.2),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RatingsFromProductSelectedWidget(
                                  productId: productId),
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
      //bottomNavigationBar:
    );
  }
}
