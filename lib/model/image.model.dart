// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'breeds.model.dart';

class ImageModel {
  final String? id;
  final String? url;
  final int? width;
  final int? height;
  List<BreedsModel> breeds;
  ImageModel({
    this.id,
    this.url,
    this.width,
    this.height,
    required this.breeds,
  });

  ImageModel copyWith({
    String? id,
    String? url,
    int? width,
    int? height,
    List<BreedsModel>? breeds,
  }) {
    return ImageModel(
      id: id ?? this.id,
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
      breeds: breeds ?? this.breeds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'width': width,
      'height': height,
      'breeds': breeds.map((x) => x.toMap()).toList(),
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] != null ? map['id'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      width: map['width'] != null ? map['width'] as int : null,
      height: map['height'] != null ? map['height'] as int : null,
      breeds: List<BreedsModel>.from(
        (map['breeds'] as List<dynamic>).map<BreedsModel>(
          (x) => BreedsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory ImageModel.fromMapFirebase(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] != null ? map['id'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      breeds: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) => ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
