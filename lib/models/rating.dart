// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

class Rating {
  Rating({required this.userId, required this.rating});

  factory Rating.fromMap(Map<String, dynamic> map) =>
      Rating(userId: map['userId'] ?? '', rating: map['rating']?.toDouble() ?? 0.0);

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));

  final String userId;

  final double rating;

  Map<String, dynamic> toMap() => {'userId': userId, 'rating': rating};

  String toJson() => json.encode(toMap());
}
