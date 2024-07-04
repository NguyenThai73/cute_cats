// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class LoginCubitState extends Equatable {
  final LoginStatus status;
  const LoginCubitState({
    required this.status,
  });

  LoginCubitState copyWith({
    LoginStatus? status,
  }) {
    return LoginCubitState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

enum LoginStatus { initial, loading, success, error, registerSuccess }
