// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class BreedsModel {
  final WeightModel? weight;
  final String? id;
  final String? name;
  final String? temperament;
  final String? vetstreet_url;
  final String? origin;
  final String? description;
  final String? life_span;
  final int? indoor;
  final int? adaptability;
  final int? affection_level;
  final int? child_friendly;
  final int? dog_friendly;
  final int? energy_level;
  final int? grooming;
  final int? health_issues;
  final int? intelligence;
  final int? shedding_level;
  final int? stranger_friendly;
  final int? social_needs;
  final int? bidability;
  final int? vocalisation;
  final int? experimental;
  final int? hairless;
  final int? natural;
  final int? rare;
  final int? suppressed_tail;
  final int? short_legs;
  final int? hypoallergenic;
  final String? wikipedia_url;
  final String? reference_image_id;
  ImageModelBreed? image;
  BreedsModel({
    this.weight,
    this.id,
    this.name,
    this.temperament,
    this.vetstreet_url,
    this.origin,
    this.description,
    this.life_span,
    this.indoor,
    this.adaptability,
    this.affection_level,
    this.child_friendly,
    this.dog_friendly,
    this.energy_level,
    this.grooming,
    this.health_issues,
    this.intelligence,
    this.shedding_level,
    this.stranger_friendly,
    this.social_needs,
    this.bidability,
    this.vocalisation,
    this.experimental,
    this.hairless,
    this.natural,
    this.rare,
    this.suppressed_tail,
    this.short_legs,
    this.hypoallergenic,
    this.wikipedia_url,
    this.reference_image_id,
    this.image,
  });

  BreedsModel copyWith({
    WeightModel? weight,
    String? id,
    String? name,
    String? temperament,
    String? vetstreet_url,
    String? origin,
    String? description,
    String? life_span,
    int? indoor,
    int? adaptability,
    int? affection_level,
    int? child_friendly,
    int? dog_friendly,
    int? energy_level,
    int? grooming,
    int? health_issues,
    int? intelligence,
    int? shedding_level,
    int? stranger_friendly,
    int? social_needs,
    int? bidability,
    int? vocalisation,
    int? experimental,
    int? hairless,
    int? natural,
    int? rare,
    int? suppressed_tail,
    int? short_legs,
    int? hypoallergenic,
    String? wikipedia_url,
    String? reference_image_id,
    ImageModelBreed? image,
  }) {
    return BreedsModel(
      weight: weight ?? this.weight,
      id: id ?? this.id,
      name: name ?? this.name,
      temperament: temperament ?? this.temperament,
      vetstreet_url: vetstreet_url ?? this.vetstreet_url,
      origin: origin ?? this.origin,
      description: description ?? this.description,
      life_span: life_span ?? this.life_span,
      indoor: indoor ?? this.indoor,
      adaptability: adaptability ?? this.adaptability,
      affection_level: affection_level ?? this.affection_level,
      child_friendly: child_friendly ?? this.child_friendly,
      dog_friendly: dog_friendly ?? this.dog_friendly,
      energy_level: energy_level ?? this.energy_level,
      grooming: grooming ?? this.grooming,
      health_issues: health_issues ?? this.health_issues,
      intelligence: intelligence ?? this.intelligence,
      shedding_level: shedding_level ?? this.shedding_level,
      stranger_friendly: stranger_friendly ?? this.stranger_friendly,
      social_needs: social_needs ?? this.social_needs,
      bidability: bidability ?? this.bidability,
      vocalisation: vocalisation ?? this.vocalisation,
      experimental: experimental ?? this.experimental,
      hairless: hairless ?? this.hairless,
      natural: natural ?? this.natural,
      rare: rare ?? this.rare,
      suppressed_tail: suppressed_tail ?? this.suppressed_tail,
      short_legs: short_legs ?? this.short_legs,
      hypoallergenic: hypoallergenic ?? this.hypoallergenic,
      wikipedia_url: wikipedia_url ?? this.wikipedia_url,
      reference_image_id: reference_image_id ?? this.reference_image_id,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weight': weight?.toMap(),
      'id': id,
      'name': name,
      'temperament': temperament,
      'vetstreet_url': vetstreet_url,
      'origin': origin,
      'description': description,
      'life_span': life_span,
      'indoor': indoor,
      'adaptability': adaptability,
      'affection_level': affection_level,
      'child_friendly': child_friendly,
      'dog_friendly': dog_friendly,
      'energy_level': energy_level,
      'grooming': grooming,
      'health_issues': health_issues,
      'intelligence': intelligence,
      'shedding_level': shedding_level,
      'stranger_friendly': stranger_friendly,
      'social_needs': social_needs,
      'bidability': bidability,
      'vocalisation': vocalisation,
      'experimental': experimental,
      'hairless': hairless,
      'natural': natural,
      'rare': rare,
      'suppressed_tail': suppressed_tail,
      'short_legs': short_legs,
      'hypoallergenic': hypoallergenic,
      'wikipedia_url': wikipedia_url,
      'reference_image_id': reference_image_id,
      'image': image?.toMap(),
    };
  }

  factory BreedsModel.fromMap(Map<String, dynamic> map) {
    return BreedsModel(
      weight: map['weight'] != null ? WeightModel.fromMap(map['weight'] as Map<String, dynamic>) : null,
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      temperament: map['temperament'] != null ? map['temperament'] as String : null,
      vetstreet_url: map['vetstreet_url'] != null ? map['vetstreet_url'] as String : null,
      origin: map['origin'] != null ? map['origin'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      life_span: map['life_span'] != null ? map['life_span'] as String : null,
      indoor: map['indoor'] != null ? map['indoor'] as int : null,
      adaptability: map['adaptability'] != null ? map['adaptability'] as int : null,
      affection_level: map['affection_level'] != null ? map['affection_level'] as int : null,
      child_friendly: map['child_friendly'] != null ? map['child_friendly'] as int : null,
      dog_friendly: map['dog_friendly'] != null ? map['dog_friendly'] as int : null,
      energy_level: map['energy_level'] != null ? map['energy_level'] as int : null,
      grooming: map['grooming'] != null ? map['grooming'] as int : null,
      health_issues: map['health_issues'] != null ? map['health_issues'] as int : null,
      intelligence: map['intelligence'] != null ? map['intelligence'] as int : null,
      shedding_level: map['shedding_level'] != null ? map['shedding_level'] as int : null,
      stranger_friendly: map['stranger_friendly'] != null ? map['stranger_friendly'] as int : null,
      social_needs: map['social_needs'] != null ? map['social_needs'] as int : null,
      bidability: map['bidability'] != null ? map['bidability'] as int : null,
      vocalisation: map['vocalisation'] != null ? map['vocalisation'] as int : null,
      experimental: map['experimental'] != null ? map['experimental'] as int : null,
      hairless: map['hairless'] != null ? map['hairless'] as int : null,
      natural: map['natural'] != null ? map['natural'] as int : null,
      rare: map['rare'] != null ? map['rare'] as int : null,
      suppressed_tail: map['suppressed_tail'] != null ? map['suppressed_tail'] as int : null,
      short_legs: map['short_legs'] != null ? map['short_legs'] as int : null,
      hypoallergenic: map['hypoallergenic'] != null ? map['hypoallergenic'] as int : null,
      wikipedia_url: map['wikipedia_url'] != null ? map['wikipedia_url'] as String : null,
      reference_image_id: map['reference_image_id'] != null ? map['reference_image_id'] as String : null,
      image: map['image'] != null ? ImageModelBreed.fromMap(map['image'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BreedsModel.fromJson(String source) => BreedsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant BreedsModel other) {
    if (identical(this, other)) return true;

    return other.weight == weight &&
        other.id == id &&
        other.name == name &&
        other.temperament == temperament &&
        other.vetstreet_url == vetstreet_url &&
        other.origin == origin &&
        other.description == description &&
        other.life_span == life_span &&
        other.indoor == indoor &&
        other.adaptability == adaptability &&
        other.affection_level == affection_level &&
        other.child_friendly == child_friendly &&
        other.dog_friendly == dog_friendly &&
        other.energy_level == energy_level &&
        other.grooming == grooming &&
        other.health_issues == health_issues &&
        other.intelligence == intelligence &&
        other.shedding_level == shedding_level &&
        other.stranger_friendly == stranger_friendly &&
        other.vocalisation == vocalisation &&
        other.experimental == experimental &&
        other.hairless == hairless &&
        other.natural == natural &&
        other.rare == rare &&
        other.suppressed_tail == suppressed_tail &&
        other.short_legs == short_legs &&
        other.hypoallergenic == hypoallergenic &&
        other.wikipedia_url == wikipedia_url &&
        other.reference_image_id == reference_image_id;
  }
}

class WeightModel {
  final String? imperial;
  final String? metric;
  WeightModel({
    this.imperial,
    this.metric,
  });

  WeightModel copyWith({
    String? imperial,
    String? metric,
  }) {
    return WeightModel(
      imperial: imperial ?? this.imperial,
      metric: metric ?? this.metric,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imperial': imperial,
      'metric': metric,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      imperial: map['imperial'] != null ? map['imperial'] as String : null,
      metric: map['metric'] != null ? map['metric'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightModel.fromJson(String source) => WeightModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant WeightModel other) {
    if (identical(this, other)) return true;

    return other.imperial == imperial && other.metric == metric;
  }
}

class ImageModelBreed {
  final String? id;
  final String? url;
  ImageModelBreed({
    this.id,
    this.url,
  });

  ImageModelBreed copyWith({
    String? id,
    String? url,
    int? width,
  }) {
    return ImageModelBreed(
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
    };
  }

  factory ImageModelBreed.fromMap(Map<String, dynamic> map) {
    return ImageModelBreed(
      id: map['id'] != null ? map['id'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModelBreed.fromJson(String source) => ImageModelBreed.fromMap(json.decode(source) as Map<String, dynamic>);
}
