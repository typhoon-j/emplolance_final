import 'package:get/get.dart';

class SearchUserController extends GetxController {
  final List<Map<String, dynamic>> searchedUsers = [
    {
      'fullName': 'fullName',
      'email': 'email',
      'photo': 'photo',
      'password': 'password',
      'description': 'description',
      'userId': 'userId'
    },
  ];

  Rx<List<Map<String, dynamic>>> foundUsers =
      Rx<List<Map<String, dynamic>>>([]);

  @override
  void onInit() {
    super.onInit();
    foundUsers.value = searchedUsers;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void filterUser(String userName) {
    List<Map<String, dynamic>> results = [];
    if (userName.isEmpty) {
      results = searchedUsers;
    } else {
      results = searchedUsers
          .where((element) => element['fullname']
              .toString()
              .toLowerCase()
              .contains(userName.toLowerCase()))
          .toList();
    }
    foundUsers.value = results;
  }
}
