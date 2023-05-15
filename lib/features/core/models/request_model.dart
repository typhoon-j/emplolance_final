import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RequestModel extends Equatable {
  final String productId;
  final String consumerId;
  final String publisherId;
  final String description;
  final String requestId;
  final bool isPending;
  final bool isAccepted;
  final bool isCancelled;
  final bool isInProgress;
  final bool isFinished;

  const RequestModel({
    required this.productId,
    required this.consumerId,
    required this.publisherId,
    required this.description,
    required this.requestId,
    required this.isPending,
    required this.isAccepted,
    required this.isCancelled,
    required this.isInProgress,
    required this.isFinished,
  });

  RequestModel copyWith({
    String? productId,
    String? consumerId,
    String? publisherId,
    String? description,
    String? requestId,
    bool? isPending,
    bool? isAccepted,
    bool? isCancelled,
    bool? isInProgress,
    bool? isFinished,
  }) {
    return RequestModel(
      productId: productId ?? this.productId,
      consumerId: consumerId ?? this.consumerId,
      publisherId: publisherId ?? this.publisherId,
      description: description ?? this.description,
      requestId: requestId ?? this.requestId,
      isPending: isPending ?? this.isPending,
      isAccepted: isAccepted ?? this.isAccepted,
      isCancelled: isCancelled ?? this.isCancelled,
      isInProgress: isInProgress ?? this.isInProgress,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'consumerId': consumerId,
      'publisherId': publisherId,
      'description': description,
      'requestId': requestId,
      'isPending': isPending,
      'isAccepted': isAccepted,
      'isCancelled': isCancelled,
      'isInProgress': isInProgress,
      'isFinished': isFinished,
    };
  }

  factory RequestModel.fromSnapshot(DocumentSnapshot snap) {
    return RequestModel(
      productId: snap['productId'] as String,
      consumerId: snap['consumerId'] as String,
      publisherId: snap['publisherId'] as String,
      description: snap['description'] as String,
      requestId: snap['requestId'] as String,
      isPending: snap['isPending'] as bool,
      isAccepted: snap['isAccepted'] as bool,
      isCancelled: snap['isCancelled'] as bool,
      isInProgress: snap['isInProgress'] as bool,
      isFinished: snap['isFinished'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      productId,
      consumerId,
      publisherId,
      description,
      requestId,
      isPending,
      isAccepted,
      isCancelled,
      isInProgress,
      isFinished,
    ];
  }

  static List<RequestModel> requests = [
    const RequestModel(
        productId: 'jkflds',
        consumerId: 'kjglfjdkg',
        publisherId: 'ifjsdlkfsd',
        description: 'Programacion Dsecripcion',
        requestId: 'kfldsf',
        isPending: true,
        isAccepted: false,
        isCancelled: false,
        isInProgress: false,
        isFinished: false)
  ];
}
