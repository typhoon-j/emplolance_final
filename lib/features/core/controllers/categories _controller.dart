import 'package:emplolance/features/authentication/repository/authentication_repository.dart';
import 'package:emplolance/features/core/models/categories_model.dart';
import 'package:emplolance/features/core/models/product_model.dart';
import 'package:emplolance/features/core/repository/categories_repository.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  static CategoriesController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _categoriesRepo = Get.put(CategoriesRepository());

  var products = <DashboardCategoriesModel>[].obs;

  Future<List<ProductModel>> getCategoryProductsData(String category) async {
    return await _categoriesRepo.getProductsFromCategory(category);
  }

  Future<List<DashboardCategoriesModel>> getAllCategories() async {
    return await _categoriesRepo.allCategories();
  }
}
