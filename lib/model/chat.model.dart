// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cat_lover/model/user.model.dart';

class ChatModel {
  String? id;
  String? sendBy;
  String? type;
  String? content;
  String? time;
  UserModel? user;
  ChatModel({
    this.id,
    this.sendBy,
    this.type,
    this.content,
    this.time,
    this.user,
  });
  ChatModel copyWith({
    String? id,
    String? sendBy,
    String? type,
    String? content,
    String? time,
  }) {
    return ChatModel(
      id: id ?? this.id,
      sendBy: sendBy ?? this.sendBy,
      type: type ?? this.type,
      content: content ?? this.content,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sendBy': sendBy,
      'type': type,
      'content': content,
      'time': time,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] != null ? map['id'] as String : null,
      sendBy: map['sendBy'] != null ? map['sendBy'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
