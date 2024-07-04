// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class SplashCubitState extends Equatable {
  final SplashStatus status;
  const SplashCubitState({
    required this.status,
  });

  SplashCubitState copyWith({
    SplashStatus? status,
  }) {
    return SplashCubitState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

enum SplashStatus { initial, authen, unAuthen }
