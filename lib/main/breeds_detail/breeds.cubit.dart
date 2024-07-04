// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cat_lover/component/list.state.dart';
import 'package:cat_lover/controller/cat.controller.dart';
import 'package:cat_lover/model/breeds.model.dart';
import 'package:cat_lover/model/image.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'breeds.cubit.state.dart';

class BreedsCubit extends Cubit<BreedsCubitState> {
  final BreedsModel breedsModel;
  final ScrollController scrollController = ScrollController();
  int page = 0;

  BreedsCubit({
    required this.breedsModel,
  }) : super(
          BreedsCubitState(
            breedsModel: breedsModel,
          ),
        ) {
    getData();
    scrollController.addListener(_onScroll);
  }

  getData() async {
    emit(state.copyWith(
      list: [],
      status: ListLoadStatus.loading,
      isFullStatus: IsFullStatus.havemore,
    ));
    var breedsModelGet = await CatController().getBreeds(
      breedId: breedsModel.id ?? "",
    );
    var imageBreed = await CatController().getImage(imageId: breedsModelGet?.reference_image_id ?? "");
    breedsModelGet?.image = ImageModelBreed(id: imageBreed?.id ?? "", url: imageBreed?.url ?? "");
    var listImage = await CatController().getListImage(page: page, breedIds: breedsModel.id ?? "");
    emit(state.copyWith(list: listImage, status: ListLoadStatus.success, breedsModelNew: breedsModelGet));
  }

  Future<List<ImageModel>> getImageMore() async {
    page++;
    return await CatController().getListImage(page: page, breedIds: breedsModel.id ?? "");
  }

  Future<void> _onScroll() async {
    if (state.status == ListLoadStatus.loading) return;
    if ((scrollController.position.extentAfter < 100) && (scrollController.position.extentBefore > 0)) {
      // if (state.status != ListLoadStatus.loadmore && state.isFullStatus != IsFullStatus.isfull) {
      //   emit(state.copyWith(
      //     status: ListLoadStatus.loadmore,
      //   ));
      //   var listAddMore = await getImageMore();
      //   if (listAddMore.isEmpty) {
      //     emit(state.copyWith(status: ListLoadStatus.success, isFullStatus: IsFullStatus.isfull));
      //   } else {
      //     emit(state.copyWith(status: ListLoadStatus.success, list: [...state.list, ...listAddMore]));
      //   }
      // }
    }
  }
}
