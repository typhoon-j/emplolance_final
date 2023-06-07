import 'dart:developer';

import 'package:emplolance/features/authentication/repository/user_repository.dart';
import 'package:emplolance/features/core/repository/product_repository.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class ProductController extends GetxController {
  final DatabaseService database = DatabaseService();
  //List<ProductModel> products = ProductModel.products.obs;

  var products = <ProductModel>[].obs;
  var allProducts = <ProductModel>[].obs;
  //var productsUser = <ProductModel>[].obs;

  var newProduct = {}.obs;
  var updatedProduct = {}.obs;

  @override
  void onInit() {
    products.bindStream(database.getUserProducts());
    allProducts.bindStream(database.getAllProducts());
    super.onInit();
  }

  getProductData(String productId) {
    return database.getProductDetails(productId);
  }

  getUserData(String userId) {
    return database.getUserDetailsId(userId);
  }

  Future<List<ProductModel>> getProductSelectedUser(String userId) async {
    return await database.getUserSelectedProducts(userId);
  }

  updateProductData(ProductModel product) async {
    log(product.id.toString());
    await database.updateProduct(product);
  }

  updateProductAvailableData(ProductModel productAvailableData) async {
    await database.updateProductAvailableData(productAvailableData);
  }
}
