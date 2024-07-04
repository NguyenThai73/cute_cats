// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:cat_lover/controller/user.controller.dart';
import 'package:cat_lover/model/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.cubit.state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  LoginCubit() : super(const LoginCubitState(status: LoginStatus.initial));

  Future<UserModel?> login() async {
    emit(state.copyWith(status: LoginStatus.loading));
    var userLogin = await UserController().login(email: emailController.text, pass: passwordController.text);
    if (userLogin != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email", emailController.text);
      prefs.setString("pass", passwordController.text);
      emit(state.copyWith(status: LoginStatus.success));
    } else {
      emit(state.copyWith(status: LoginStatus.error));
    }
    return userLogin;
  }
}
