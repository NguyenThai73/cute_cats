import 'package:cat_lover/model/buy.point.select.model.dart';
import 'package:equatable/equatable.dart';

class BuyFishCubitState extends Equatable {
  final BuyFishStatus status;
  final BuyOptionModel? buyOptionModel;
  const BuyFishCubitState({
    required this.status,
     this.buyOptionModel,
  });

  BuyFishCubitState copyWith({
    BuyFishStatus? status,
    BuyOptionModel? buyOptionModel,
  }) {
    return BuyFishCubitState(
      status: status ?? this.status,
      buyOptionModel: buyOptionModel ?? this.buyOptionModel,
    );
  }

  @override
  List<Object?> get props => [status, buyOptionModel];
}

enum BuyFishStatus { initial, loading, success, error }
