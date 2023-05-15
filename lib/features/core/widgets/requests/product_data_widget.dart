import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';

class ProductDataFromRequestWidget extends StatelessWidget {
  ProductDataFromRequestWidget({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final String productId;
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getProductData(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            ProductModel productData = snapshot.data as ProductModel;
            return Text(
              productData.name,
              style: Theme.of(context).textTheme.headline4,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
      },
    );
  }
}
