import 'package:emplolance/features/core/repository/product_repository.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class ProductController extends GetxController {
  final DatabaseService database = DatabaseService();
  //List<ProductModel> products = ProductModel.products.obs;

  var products = <ProductModel>[].obs;
  //var productsUser = <ProductModel>[].obs;

  var newProduct = {}.obs;

  @override
  void onInit() {
    products.bindStream(database.getUserProducts());
    super.onInit();
  }

  getProductData(String productId) {
    return database.getProductDetails(productId);
  }
}
