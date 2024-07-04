// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:cat_lover/model/ranking.model.dart';
import 'package:equatable/equatable.dart';

class TopCatCubitState extends Equatable {
  final RankingStatus status;
  List<RankingModel> listRank;
  List<String> listRankId;
  TopCatCubitState({
    required this.status,
    required this.listRank,
    required this.listRankId,
  });

  TopCatCubitState copyWith({
    RankingStatus? status,
    List<RankingModel>? listRank,
    List<String>? listRankId,
  }) {
    return TopCatCubitState(
      status: status ?? this.status,
      listRank: listRank ?? this.listRank,
      listRankId: listRankId ?? this.listRankId,
    );
  }

  @override
  List<Object> get props => [
        status,
        listRankId,
        listRankId.length,
        listRank,
        listRank.length,
      ];
}

enum RankingStatus { initial, loading, success, error }
