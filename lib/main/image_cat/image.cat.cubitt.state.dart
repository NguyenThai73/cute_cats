// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cat_lover/model/image.model.dart';
import 'package:equatable/equatable.dart';

class ImageCatCubitState extends Equatable {
  final ImageCatStatus status;
  final ImageModel imageModel;
  const ImageCatCubitState({
    required this.status,
    required this.imageModel,
  });

  ImageCatCubitState copyWith({
    ImageCatStatus? status,
    ImageModel? imageModel,
  }) {
    return ImageCatCubitState(
      status: status ?? this.status,
      imageModel: imageModel ?? this.imageModel,
    );
  }

  @override
  List<Object> get props => [status, imageModel];
}

enum ImageCatStatus { initial, loading, success, error }
