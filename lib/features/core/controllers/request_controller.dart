import 'package:emplolance/features/core/models/request_model.dart';
import 'package:emplolance/features/core/repository/request_repository.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  final RequestRepository database = RequestRepository();
  var requests = <RequestModel>[].obs;
  var newRequest = {}.obs;

  @override
  void onInit() {
    requests.bindStream(database.getUserRequests());
    super.onInit();
  }

  getConsumerData(String userId) {
    return database.getUserDetailsId(userId);
  }

  getRequestData(String requestId) {
    return database.getRequestDetails(requestId);
  }

  updateRequestData(RequestModel request) async {
    await database.updateRequestStatus(request);
  }
}
