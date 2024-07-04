import 'package:cat_lover/component/list.state.dart';
import 'package:cat_lover/controller/cat.controller.dart';
import 'package:cat_lover/model/breeds.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<ListState<BreedsModel>> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController textSearch = TextEditingController();
  int page = 0;
  HomeCubit() : super(const ListState()) {
    getData();
    scrollController.addListener(_onScroll);
  }

  getData() async {
    page = 0;
    emit(state.copyWith(status: ListLoadStatus.loading, isFullStatus: IsFullStatus.havemore));
    List<BreedsModel> data = await CatController().getListBreeds(page: page);
    emit(state.copyWith(status: ListLoadStatus.success, list: data));
  }

  search() async {
    if (textSearch.text.isNotEmpty) {
      page = 0;
      emit(state.copyWith(status: ListLoadStatus.loading, isFullStatus: IsFullStatus.havemore));
      List<BreedsModel> data = await CatController().getListBreeds(breedName: textSearch.text, page: page);
      emit(state.copyWith(status: ListLoadStatus.success, list: data));
    } else {
      getData();
    }
  }

  Future<List<BreedsModel>> loadMore() async {
    page++;
    return await CatController().getListBreeds(page: page);
  }

  getDataBySearch() async {
    page = 0;
    emit(state.copyWith(status: ListLoadStatus.loading, isFullStatus: IsFullStatus.havemore));
    List<BreedsModel> data = await CatController().getListBreeds(page: page, breedName: textSearch.text);
    emit(state.copyWith(status: ListLoadStatus.success, list: data));
  }

  Future<void> _onScroll() async {
    if (state.status == ListLoadStatus.loading) return;
    if ((scrollController.position.extentAfter < 100) && (scrollController.position.extentBefore > 0)) {
      if (state.status != ListLoadStatus.loadmore && state.isFullStatus != IsFullStatus.isfull && textSearch.text.isEmpty) {
        emit(state.copyWith(status: ListLoadStatus.loadmore));
        var listAddMore = await loadMore();
        if (listAddMore.isEmpty) {
          emit(state.copyWith(status: ListLoadStatus.success, isFullStatus: IsFullStatus.isfull));
        } else {
          emit(state.copyWith(status: ListLoadStatus.success, list: [...state.list, ...listAddMore]));
        }
      }
    }
    if (scrollController.position.extentBefore == 0 && scrollController.position.extentAfter > 199) {
      // getData();
    }
  }
}
