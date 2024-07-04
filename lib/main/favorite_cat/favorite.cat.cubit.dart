// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cat_lover/model/image.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'favorite.cat.cubit.state.dart';

class FavoriteCatCubit extends Cubit<FavoriteCatCubitState> {
  final firebaseClould = FirebaseFirestore.instance;
  String userIdNow = "";
  FavoriteCatCubit() : super(FavoriteCatCubitState(listId: [], listFavorite: [], status: FavoriteCatStatus.initial));
  getData(String userId) async {
    emit(state.copyWith(status: FavoriteCatStatus.loading));
    try {
      userIdNow = userId;
      var query = await firebaseClould.collection("user").doc(userId).collection("favorite").get();
      List<ImageModel> listFavorites = [];
      List<String> listIdFavorites = [];
      for (var element in query.docs) {
        ImageModel imageModel = ImageModel.fromMapFirebase(element.data());
        listFavorites.add(imageModel);
        listIdFavorites.add(imageModel.id ?? "");
      }
      emit(state.copyWith(listFavorite: listFavorites, listId: listIdFavorites, status: FavoriteCatStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FavoriteCatStatus.error));
    }
  }

  void acctionFavorites({required ImageModel imageModel}) {
    emit(state.copyWith(status: FavoriteCatStatus.loading));
    if (imageModel.id != null) {
      if (state.listId.contains(imageModel.id)) {
        var index = state.listId.indexOf(imageModel.id ?? "");
        state.listFavorite.removeAt(index);
        state.listId.removeAt(index);
        firebaseClould.collection("user").doc(userIdNow).collection("favorite").doc(imageModel.id.toString()).delete();
      } else {
        state.listFavorite.add(imageModel);
        state.listId.add(imageModel.id ?? "");
        firebaseClould
            .collection("user")
            .doc(userIdNow)
            .collection("favorite")
            .doc(imageModel.id.toString())
            .set({"id": imageModel.id, "url": imageModel.url});
      }
      emit(state.copyWith(listFavorite: state.listFavorite, listId: state.listId, status: FavoriteCatStatus.success));
    }
  }

  cleanData() {
    emit(state.copyWith(listFavorite: [], listId: [], status: FavoriteCatStatus.initial));
  }
}
