import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user.model.dart';
import 'user.app.cubit.state.dart';

class UserAppCubit extends Cubit<UserAppCubitState> {
  final firebaseClould = FirebaseFirestore.instance.collection("user");
  UserAppCubit() : super(const UserAppCubitState(status: UserAppStatus.initial, userModel: null));

  updateUser(UserModel? userNew) async {
    emit(state.copyWith(status: UserAppStatus.loading));
    emit(state.copyWith(status: UserAppStatus.success, userModel: userNew));
  }

  updateName(String fullname) async {
    emit(state.copyWith(status: UserAppStatus.loading));
    await firebaseClould.doc(state.userModel?.id).set(state.userModel?.copyWith(name: fullname).toMap() ?? {});
    emit(state.copyWith(status: UserAppStatus.success, userModel: state.userModel?.copyWith(name: fullname)));
  }

  updateAvatar(String url) async {
    emit(state.copyWith(status: UserAppStatus.loading));
    await firebaseClould.doc(state.userModel?.id).set(state.userModel?.copyWith(avatar: url).toMap() ?? {});
    emit(state.copyWith(status: UserAppStatus.success, userModel: state.userModel?.copyWith(avatar: url)));
  }

  addFish(int fish) async {
    var fishNow = state.userModel?.first ?? 0;
    emit(state.copyWith(status: UserAppStatus.loading));
    await firebaseClould.doc(state.userModel?.id).set(state.userModel?.copyWith(first: fishNow + fish).toMap() ?? {});
    emit(state.copyWith(status: UserAppStatus.success, userModel: state.userModel?.copyWith(first: fishNow + fish)));
  }

  Future<bool> updatePassword(String namePass) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(namePass);
      return true;
    } catch (e) {
      return false;
    }
  }
}
