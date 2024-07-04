import 'package:cat_lover/controller/user.controller.dart';
import 'package:cat_lover/model/ranking.model.dart';
import 'package:cat_lover/model/user.feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'top.user.cubit.state.dart';

class TopUserCubit extends Cubit<TopUserCubitState> {
  final RankingModel rankingModel;
  TopUserCubit({required this.rankingModel}) : super(TopUserCubitState(status: TopUserStatus.initial, listUserFeed: [])) {
    getData();
  }
  final firebaseClould = FirebaseFirestore.instance.collection("ranking");
  getData() async {
    emit(state.copyWith(status: TopUserStatus.loading));
    var query = await firebaseClould.doc(rankingModel.breedsId).collection("userFeed").orderBy("fish", descending: true).get();
    List<UserFeed> listRankGet = [];
    for (var element in query.docs) {
      UserFeed userFeed = UserFeed.fromMap(element.data());
      userFeed.userModel = await UserController().getUser(userFeed.userId ?? "");
      listRankGet.add(userFeed);
    }
    emit(state.copyWith(listUserFeed: listRankGet, status: TopUserStatus.success));
  }
}
