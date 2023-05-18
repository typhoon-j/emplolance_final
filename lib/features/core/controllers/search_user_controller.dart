import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:emplolance/features/core/models/product_model.dart';
import 'package:emplolance/features/core/repository/search_repository.dart';
import 'package:get/get.dart';

class SearchUserController extends GetxController {
  SearchRepository database = SearchRepository();
  var users = <UserModel>[].obs;
  var products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  searchUser(String search) {
    users.bindStream(database.getUserSearched(search));
  }

  searchProduct(String search, String category) {
    products.bindStream(database.getProductSearched(search, category));
  }
}
