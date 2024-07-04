// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:cat_lover/model/chat.model.dart';
import 'package:equatable/equatable.dart';

class ChatCubitState extends Equatable {
  ChatStatus status;
  List<ChatModel> listChat;
  List<String> listForbiddenWord;
  ChatCubitState({
    required this.status,
    required this.listChat,
    required this.listForbiddenWord,
  });

  ChatCubitState copyWith({
    ChatStatus? status,
    List<ChatModel>? listChat,
    List<String>? listForbiddenWord,
  }) {
    return ChatCubitState(
      status: status ?? this.status,
      listChat: listChat ?? this.listChat,
      listForbiddenWord: listForbiddenWord ?? this.listForbiddenWord,
    );
  }

  @override
  List<Object> get props => [status, listChat, listChat.length, listForbiddenWord, listForbiddenWord.length];
}

enum ChatStatus { initial, loading, success, error }
