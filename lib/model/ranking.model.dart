// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RankingModel {
  final String? breedsId;
  final String? image;
  final String? name;
  final String? origin;
  final int? fish;
  RankingModel({
    this.breedsId,
    this.image,
    this.name,
    this.origin,
    this.fish,
  });

  RankingModel copyWith({
    String? breedsId,
    String? image,
    String? name,
    String? origin,
    int? fish,
  }) {
    return RankingModel(
      breedsId: breedsId ?? this.breedsId,
      image: image ?? this.image,
      name: name ?? this.name,
      origin: origin ?? this.origin,
      fish: fish ?? this.fish,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'breedsId': breedsId,
      'image': image,
      'name': name,
      'origin': origin,
      'fish': fish,
    };
  }

  factory RankingModel.fromMap(Map<String, dynamic> map) {
    return RankingModel(
      breedsId: map['breedsId'] != null ? map['breedsId'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      origin: map['origin'] != null ? map['origin'] as String : null,
      fish: map['fish'] != null ? map['fish'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RankingModel.fromJson(String source) => RankingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
