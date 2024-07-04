// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cat_lover/model/user.model.dart';
import 'package:equatable/equatable.dart';

class UserAppCubitState extends Equatable {
  final UserAppStatus status;
  final UserModel? userModel;
  const UserAppCubitState({
    required this.status,
    required this.userModel,
  });

  UserAppCubitState copyWith({
    UserAppStatus? status,
    UserModel? userModel,
  }) {
    return UserAppCubitState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [status, userModel];
}

enum UserAppStatus { initial, loading, success, error }
