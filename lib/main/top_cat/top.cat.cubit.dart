import 'package:bloc/bloc.dart';
import 'package:cat_lover/model/breeds.model.dart';
import 'package:cat_lover/model/ranking.model.dart';
import 'package:cat_lover/model/user.feed.dart';
import 'package:cat_lover/model/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'top.cat.cubit.state.dart';

class TopCatCubit extends Cubit<TopCatCubitState> {
  UserModel? userModel;
  final firebaseClould = FirebaseFirestore.instance.collection("ranking");
  TopCatCubit() : super(TopCatCubitState(listRank: [], listRankId: [], status: RankingStatus.initial));

  getData() async {
    emit(state.copyWith(status: RankingStatus.loading));
    var query = await firebaseClould.orderBy("fish", descending: true).get();
    List<RankingModel> listRankGet = [];
    List<String> listRankIdGet = [];
    for (var element in query.docs) {
      RankingModel rankingModel = RankingModel.fromMap(element.data());
      listRankGet.add(rankingModel);
      listRankIdGet.add(rankingModel.breedsId ?? "");
    }
    emit(state.copyWith(listRank: listRankGet, listRankId: listRankIdGet, status: RankingStatus.success));
  }

  cleanData() {
    emit(state.copyWith(listRank: [], listRankId: [], status: RankingStatus.initial));
  }

  acctionHandleRanking({required BreedsModel breedsModel, required UserModel userModelFeed}) async {
    userModel = userModelFeed;
    emit(state.copyWith(status: RankingStatus.loading));
    if (breedsModel.id != null) {
      if (state.listRankId.contains(breedsModel.id)) {
        var index = state.listRankId.indexOf(breedsModel.id ?? "");
        var currentFish = state.listRank[index].fish ?? 0;
        firebaseClould.doc(state.listRankId[index]).set(state.listRank[index].copyWith(fish: currentFish + 1).toMap());
      } else {
        firebaseClould.doc(breedsModel.id ?? "").set(
            RankingModel(breedsId: breedsModel.id, name: breedsModel.name, image: breedsModel.image?.url, origin: breedsModel.origin, fish: 1)
                .toMap());
      }
      var fishNow = userModel?.first ?? 0;
      await FirebaseFirestore.instance.collection("user").doc(userModel?.id.toString()).set(userModel?.copyWith(first: fishNow - 1).toMap() ?? {});
      var userQuerry = firebaseClould.doc(breedsModel.id ?? "").collection("userFeed").doc(userModel?.id.toString());
      var querryUser = await userQuerry.get();
      if (querryUser.exists) {
        UserFeed userFeed = UserFeed.fromMap(querryUser.data() ?? {});
        var currentFishNow = userFeed.fish ?? 0;
        userQuerry.set({"userId": userModel?.id.toString(), "fish": currentFishNow + 1});
      } else {
        userQuerry.set({"userId": userModel?.id.toString(), "fish": 1});
      }
      getData();
    }
  }
}
