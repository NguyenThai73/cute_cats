import 'package:cat_lover/controller/user.controller.dart';
import 'package:cat_lover/model/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'block.cubit.state.dart';

class BlockCubit extends Cubit<BlockCubitState> {
  final firebaseClould = FirebaseFirestore.instance.collection("user");
  BlockCubit() : super(BlockCubitState(status: BlockStatus.initial, listBlock: [], listBlockId: []));
  UserModel? userModelNow;
  getData([UserModel? userModel]) async {
    if (userModel != null) {
      userModelNow = userModel;
    }
    emit(state.copyWith(status: BlockStatus.loading));
    var queryBlock = await firebaseClould.doc(userModelNow?.id ?? "").collection("block").get();
    List<UserModel> listData = [];
    List<String> listDataId = [];
    for (var element in queryBlock.docs) {
      UserModel userModelId = UserModel.fromMap(element.data());
      UserModel? userModel = await UserController().getUser(userModelId.id ?? "");
      if (userModel != null) {
        listData.add(userModel);
        listDataId.add(userModel.id ?? "");
      }
    }
    emit(state.copyWith(status: BlockStatus.success, listBlockId: listDataId, listBlock: listData));
  }

  void handleBlock({required UserModel userModel}) {
    if (userModel.id != null) {
      emit(state.copyWith(status: BlockStatus.loading));
      if (state.listBlockId.contains(userModel.id)) {
        var index = state.listBlockId.indexOf(userModel.id ?? "");
        state.listBlockId.remove(userModel.id);
        state.listBlock.removeAt(index);
        firebaseClould.doc(userModelNow?.id ?? "").collection("block").doc(userModel.id).delete();
      } else {
        state.listBlockId.add(userModel.id ?? "");
        state.listBlock.add(userModel);
        firebaseClould.doc(userModelNow?.id ?? "").collection("block").doc(userModel.id).set({"id": userModel.id});
      }
      emit(state.copyWith(status: BlockStatus.success, listBlockId: state.listBlockId, listBlock: state.listBlock));
    }
    getData();
  }

  cleanData() {
    emit(state.copyWith(status: BlockStatus.initial, listBlockId: [], listBlock: []));
  }
}
