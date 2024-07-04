// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:cat_lover/controller/cat.controller.dart';
import 'package:cat_lover/model/image.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'image.cat.cubitt.state.dart';

class ImageCatCubit extends Cubit<ImageCatCubitState> {
  final String imageId;
  ImageCatCubit({required this.imageId}) : super(ImageCatCubitState(status: ImageCatStatus.initial, imageModel: ImageModel(breeds: []))) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: ImageCatStatus.loading));
    var data = await CatController().getImage(imageId: imageId);
    emit(state.copyWith(status: ImageCatStatus.success, imageModel: data));
  }
}
