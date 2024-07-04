import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BuyOptionModel {
  final int? id;
  final double? amount;
  final int? fish;
  final int? bonus;
  final String? productId;
  BuyOptionModel({
    this.id,
    this.amount,
    this.fish,
    this.bonus,
    this.productId,
  });

  BuyOptionModel copyWith({
    int? id,
    double? amount,
    int? fish,
    int? bonus,
    String? productId,
  }) {
    return BuyOptionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      fish: fish ?? this.fish,
      bonus: bonus ?? this.bonus,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'fish': fish,
      'bonus': bonus,
      'productId': productId,
    };
  }

  factory BuyOptionModel.fromMap(Map<String, dynamic> map) {
    return BuyOptionModel(
      id: map['id'] != null ? map['id'] as int : null,
      amount: map['amount'] != null ? map['amount'] as double : null,
      fish: map['fish'] != null ? map['fish'] as int : null,
      bonus: map['bonus'] != null ? map['bonus'] as int : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyOptionModel.fromJson(String source) => BuyOptionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  int getTotalPoint() {
    var pointConvert = fish ?? 0;
    var pointBonusConvert = bonus ?? 0;
    return pointConvert + pointBonusConvert;
  }
}
