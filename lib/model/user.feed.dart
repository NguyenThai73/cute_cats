// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cat_lover/model/user.model.dart';

class UserFeed {
  final String? userId;
  final int? fish;
  UserModel? userModel;
  UserFeed({
    this.userId,
    this.fish,
  });

  UserFeed copyWith({
    String? userId,
    int? fish,
  }) {
    return UserFeed(
      userId: userId ?? this.userId,
      fish: fish ?? this.fish,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'fish': fish,
    };
  }

  factory UserFeed.fromMap(Map<String, dynamic> map) {
    return UserFeed(
      userId: map['userId'] != null ? map['userId'] as String : null,
      fish: map['fish'] != null ? map['fish'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFeed.fromJson(String source) => UserFeed.fromMap(json.decode(source) as Map<String, dynamic>);
}
