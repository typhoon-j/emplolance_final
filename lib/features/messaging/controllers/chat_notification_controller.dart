import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../authentication/repository/user_repository.dart';

class ChatNotificationController extends GetxController {
  final _userRepo = Get.put(UserRepository());

  getUserSelectedData(String userId) {
    log('UserData in controller: $userId');
    return _userRepo.getUserSelectedDetails(userId);
  }

  Future<void> sendPushNotification(
      String? userId, String? currentFullName, String? message) async {
    var userData = await getUserSelectedData(userId!);
    var pushToken = userData.pushToken;
    log('PushToken: $pushToken');

    try {
      final body = {
        'to': pushToken,
        'notification': {
          'title': '$currentFullName te envio un mensaje: ',
          'body': message,
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

  Future<void> sendPushNotificationImage(
      String? userId, String? currentFullName) async {
    var userData = await getUserSelectedData(userId!);
    var pushToken = userData.pushToken;
    log('PushToken: $pushToken');

    try {
      final body = {
        'to': pushToken,
        'notification': {
          'title': '$currentFullName te envio una imagen: ',
          'body': 'Imagen adjunta',
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
