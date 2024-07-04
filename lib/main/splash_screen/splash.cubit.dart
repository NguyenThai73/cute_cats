// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash.cubit.state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashCubitState> {
  SplashCubit() : super(const SplashCubitState(status: SplashStatus.initial)) {
    checkLogin();
  }
  checkLogin() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email");
      var pass = prefs.getString("pass");
      if (email != null && pass != null && email != "" && pass != "") {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );
        User? user = userCredential.user;
        if (user != null) {
          emit(state.copyWith(status: SplashStatus.authen));
        } else {
          emit(state.copyWith(status: SplashStatus.unAuthen));
        }
      } else {
        emit(state.copyWith(status: SplashStatus.unAuthen));
      }
    } catch (e) {
      emit(state.copyWith(status: SplashStatus.unAuthen));
    }
  }
}
