import 'package:emplolance/features/authentication/repository/authentication_repository.dart';
import 'package:emplolance/features/core/models/categories_model.dart';
import 'package:emplolance/features/core/repository/categories_repository.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  static CategoriesController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _categoriesRepo = Get.put(CategoriesRepository());
/*
  getCategoriesData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar('Error', 'Login to continue');
    }
  }*/

  Future<List<DashboardCategoriesModel>> getAllCategories() async {
    return await _categoriesRepo.allCategories();
  }
}
