// ignore_for_file: must_be_immutable

import 'package:cat_lover/model/user.feed.dart';
import 'package:equatable/equatable.dart';

class TopUserCubitState extends Equatable {
  final TopUserStatus status;
  List<UserFeed> listUserFeed;
  TopUserCubitState({
    required this.status,
    required this.listUserFeed,
  });

  TopUserCubitState copyWith({
    TopUserStatus? status,
    List<UserFeed>? listUserFeed,
  }) {
    return TopUserCubitState(
      status: status ?? this.status,
      listUserFeed: listUserFeed ?? this.listUserFeed,
    );
  }

  @override
  List<Object> get props => [status, listUserFeed, listUserFeed.length];
}

enum TopUserStatus { initial, loading, success, error }
