import 'dart:developer';

import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/features/core/controllers/product_controller.dart';
import 'package:emplolance/features/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/image_strings.dart';
import '../../widgets/top_courses.dart';

class ProductSelectedScreen extends StatelessWidget {
  ProductSelectedScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final controller = Get.put(ProductController());
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
                                    Text('5 ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                    const Icon(
                                      Icons.star_outlined,
                                      size: 25,
                                    ),
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
                                        //solucionar el nombre del usuario que publico esto xd
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
                              UserDataProductWidget(),
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
                                height: 200,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    DashboardTopCourses(
                                        txtTheme: Theme.of(context).textTheme),
                                  ],
                                ),
                              ),
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
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFF17181C),
        ),
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            'Solicitar',
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.apply(color: tSecondaryColor),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(tPrimaryColor),
          ),
        ),
      ),
    );
  }
}

class UserDataProductWidget extends StatelessWidget {
  const UserDataProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ClipOval(
            //borderRadius: BorderRadius.circular(100),
            child: Image(
          image: AssetImage(tProfileImge),
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        )),
        Text(
          'Paco Doe (harcode)',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
