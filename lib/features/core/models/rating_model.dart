// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RatingModel extends Equatable {
  final String ratedId;
  final String raterId;
  final double rating;
  final String comment;
  const RatingModel({
    required this.ratedId,
    required this.raterId,
    required this.rating,
    required this.comment,
  });

  RatingModel copyWith({
    String? ratedId,
    String? raterId,
    double? rating,
    String? comment,
  }) {
    return RatingModel(
      ratedId: ratedId ?? this.ratedId,
      raterId: raterId ?? this.raterId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ratedId': ratedId,
      'raterId': raterId,
      'rating': rating,
      'comment': comment,
    };
  }

  factory RatingModel.fromSnapshot(DocumentSnapshot snap) {
    return RatingModel(
      ratedId: snap['ratedId'] as String,
      raterId: snap['raterId'] as String,
      rating: snap['rating'] as double,
      comment: snap['comment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ratedId, raterId, rating, comment];

  static List<RatingModel> ratings = [
    const RatingModel(
        ratedId: 'ratedId', raterId: 'raterId', rating: 5.0, comment: 'comment')
  ];
}
