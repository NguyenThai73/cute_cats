// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class RegisterCubitState extends Equatable {
  final RegisterStatus status;
  const RegisterCubitState({
    required this.status,
  });

  RegisterCubitState copyWith({
    RegisterStatus? status,
  }) {
    return RegisterCubitState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

enum RegisterStatus { initial, loading, success, error, registerSuccess }
