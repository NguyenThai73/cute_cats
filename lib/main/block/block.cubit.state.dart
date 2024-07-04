// ignore_for_file: must_be_immutable

import 'package:cat_lover/model/user.model.dart';
import 'package:equatable/equatable.dart';

class BlockCubitState extends Equatable {
  final BlockStatus status;
  List<String> listBlockId;
  List<UserModel> listBlock;

  BlockCubitState({
    required this.status,
    required this.listBlockId,
    required this.listBlock,
  });

  BlockCubitState copyWith({
    BlockStatus? status,
    List<String>? listBlockId,
    List<UserModel>? listBlock,
  }) {
    return BlockCubitState(
      status: status ?? this.status,
      listBlockId: listBlockId ?? this.listBlockId,
      listBlock: listBlock ?? this.listBlock,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listBlockId,
        listBlockId.length,
        listBlock,
        listBlock.length,
      ];
}

enum BlockStatus { initial, loading, success, error }
