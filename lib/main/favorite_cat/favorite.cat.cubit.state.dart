// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:cat_lover/model/image.model.dart';
import 'package:equatable/equatable.dart';

class FavoriteCatCubitState extends Equatable {
  final FavoriteCatStatus status;
  List<String> listId;
  List<ImageModel> listFavorite;
  FavoriteCatCubitState({
    required this.status,
    required this.listId,
    required this.listFavorite,
  });

  FavoriteCatCubitState copyWith({
    FavoriteCatStatus? status,
    List<String>? listId,
    List<ImageModel>? listFavorite,
  }) {
    return FavoriteCatCubitState(
      status: status ?? this.status,
      listId: listId ?? this.listId,
      listFavorite: listFavorite ?? this.listFavorite,
    );
  }

  @override
  List<Object> get props => [status, listFavorite, listFavorite.length, listId, listId.length];
}

enum FavoriteCatStatus { initial, loading, success, error }