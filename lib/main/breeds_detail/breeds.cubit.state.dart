// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cat_lover/component/list.state.dart';
import 'package:cat_lover/model/breeds.model.dart';
import 'package:cat_lover/model/image.model.dart';

class BreedsCubitState extends ListState<ImageModel> {
  final BreedsModel breedsModel;

  const BreedsCubitState({
    super.status,
    super.isFullStatus,
    super.list,
    required this.breedsModel,
  });

  @override
  BreedsCubitState copyWith({
    ListLoadStatus? status,
    IsFullStatus? isFullStatus,
    List<ImageModel>? list,
    BreedsModel? breedsModelNew,
  }) {
    return BreedsCubitState(
      status: status ?? this.status,
      isFullStatus: isFullStatus ?? this.isFullStatus,
      list: list ?? this.list,
      breedsModel: breedsModelNew ?? breedsModel,
    );
  }

  @override
  List<Object> get props {
    return [
      ...super.props,
      breedsModel,
    ];
  }
}
