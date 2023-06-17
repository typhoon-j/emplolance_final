import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../authentication/repository/user_repository.dart';
import '../repository/product_repository.dart';

class RequestNotificationController {
  final _userRepo = Get.put(UserRepository());
  final DatabaseService database = DatabaseService();

  getUserSelectedData(String userId) {
    log('UserData in controller: $userId');
    return _userRepo.getUserSelectedDetails(userId);
  }

  getProductData(String productId) {
    return database.getProductDetails(productId);
  }

  Future<void> sendPushNotification(String? userId, String? productId) async {
    var userData = await getUserSelectedData(userId!);
    var productData = await getProductData(productId!);
    log('PushToken: ${userData.pushToken}');

    try {
      final body = {
        'to': userData.pushToken,
        'notification': {
          'title': 'Tienes una nueva solicitud de tu anuncio: ',
          'body': productData.name,
        },
      };
      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAAsgj6AAM:APA91bF62LufrPtBFqKragbmi8kKsIh1e4JtT-cKG9XThUbS0-ql44RghcGovXYDUo58qcCyhNAcuWtqKkQUILgoMt_-hfAVN7TlSI37JbQx2Om7RRR0C1vrRn98s0VFZy-JCtvxyxFV',
          },
          body: jsonEncode(body));
      log('Response Status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNptificationError: $e');
    }
  }

  Future<void> sendPushNotificationRequestStatus(
      String? consumerId, String? productId, String message) async {
    var userData = await getUserSelectedData(consumerId!);
    var productData = await getProductData(productId!);
    log('PushToken: ${userData.pushToken}');

    try {
      final body = {
        'to': userData.pushToken,
        'notification': {
          'title': message,
          'body': productData.name,
        },
      };
      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAAsgj6AAM:APA91bF62LufrPtBFqKragbmi8kKsIh1e4JtT-cKG9XThUbS0-ql44RghcGovXYDUo58qcCyhNAcuWtqKkQUILgoMt_-hfAVN7TlSI37JbQx2Om7RRR0C1vrRn98s0VFZy-JCtvxyxFV',
          },
          body: jsonEncode(body));
      log('Response Status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNptificationError: $e');
    }
  }
}
