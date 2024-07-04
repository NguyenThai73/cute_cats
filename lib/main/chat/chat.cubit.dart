// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:cat_lover/model/chat.model.dart';
import 'package:cat_lover/model/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'chat.cubit.state.dart';
import 'package:file_picker/file_picker.dart';

class ChatCubit extends Cubit<ChatCubitState> {
  final firebaseClould = FirebaseFirestore.instance.collection("chat");
  late StreamSubscription<ChatModel> streamChat;
  final UserModel? userModel;
  TextEditingController chatController = TextEditingController();
  bool isFirst = true;
  ChatCubit({required this.userModel}) : super(ChatCubitState(status: ChatStatus.initial, listChat: [], listForbiddenWord: [])) {
    getData();
  }

  getData() async {
    streamChatApp();
    emit(state.copyWith(status: ChatStatus.loading));
    var listChat = await getListChat();
    var listForbiddenWord = await getForbiddenWord();
    emit(state.copyWith(status: ChatStatus.success, listChat: listChat, listForbiddenWord: listForbiddenWord));
  }

  streamChatApp() async {
    streamChat = streamChatFirebase().listen((event) async {
      if (isFirst) {
        isFirst = false;
      } else {
        event.user = await getUser(event.sendBy ?? "");
        emit(state.copyWith(listChat: [event, ...state.listChat]));
      }
    });
  }

  Stream<ChatModel> streamChatFirebase() {
    return firebaseClould
        .orderBy("timesort", descending: true)
        .limit(1)
        .withConverter<ChatModel>(
          fromFirestore: (snapshot, options) {
            return ChatModel.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (value, options) => value.toMap(),
        )
        .snapshots()
        .map((event) {
      var listChange = event.docChanges.where((element) => element.type == DocumentChangeType.added).map((e) {
        return e.doc.data();
      }).toList();
      if (listChange.isEmpty) {
        return ChatModel();
      }
      return listChange.first!;
    });
  }

  Future<List<ChatModel>> getListChat() async {
    var result = await firebaseClould
        .orderBy("timesort", descending: true)
        .withConverter<ChatModel>(
          fromFirestore: (snapshot, options) => ChatModel.fromMap(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toMap(),
        )
        .get();
    var list = result.docs.map((e) => e.data()).toList();
    for (var element in list) {
      element.user = await getUser(element.sendBy ?? "");
    }
    return list;
  }

  Future<List<String>> getForbiddenWord() async {
    try {
      var queryGetForbiddenWord = await FirebaseFirestore.instance.collection("setting").doc("forbidden_word").get();
      if (queryGetForbiddenWord.exists) {
        var data = queryGetForbiddenWord.data();
        if (data != null) {
          var check = queryGetForbiddenWord.data()?.containsKey("data");
          if (check == true) {
            List<String> listReturn = [];
            var listData = data['data'] as List<dynamic>;
            for (var element in listData) {
              listReturn.add(element.toString().toUpperCase());
            }
            return listReturn;
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print("Loiii: $e");
      return [];
    }
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      var query = await FirebaseFirestore.instance.collection("user").doc(userId).get();
      if (query.exists) {
        UserModel userModelNew = UserModel.fromMap(query.data() ?? {});
        return userModelNew;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void sendText() async {
    String idChat = Uuid().v4();
    await firebaseClould.doc(idChat).set({
      'id': idChat,
      'sendBy': userModel?.id ?? "",
      'type': "text",
      'content': chatController.text,
      'time': DateFormat("HH:mm dd-MM-yyyy").format(DateTime.now()),
      'timesort': DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()),
    });
    chatController.text = "";
  }

  @override
  Future<void> close() async {
    streamChat.cancel();
    return super.close();
  }

  void sendImage(String url) async {
    String idChat = Uuid().v4();
    await firebaseClould.doc(idChat).set({
      'id': idChat,
      'sendBy': userModel?.id ?? "",
      'type': "image",
      'content': url,
      'time': DateFormat("HH:mm dd-MM-yyyy").format(DateTime.now()),
      'timesort': DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()),
    });
  }
}

Future<String?> handleUploadImage() async {
  String? fileName;
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result != null) {
    try {
      String fileName = result.files.first.name;
      String path = result.files.first.path ?? "";
      await FirebaseStorage.instance.ref('Images/$fileName').putFile(File(path));
      return "https://firebasestorage.googleapis.com/v0/b/catcat-fd730.appspot.com/o/Images%2F$fileName?alt=media";
    } catch (e) {}
  } else {}
  return fileName;
}
