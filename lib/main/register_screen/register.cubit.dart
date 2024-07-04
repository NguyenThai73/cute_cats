// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:cat_lover/controller/user.controller.dart';
import 'package:cat_lover/model/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register.cubit.state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  RegisterCubit() : super(const RegisterCubitState(status: RegisterStatus.initial));

  Future<UserModel?> register() async {
    emit(state.copyWith(status: RegisterStatus.loading));
    var userLogin = await UserController().register(email: emailController.text, password: passwordController.text, name: nameController.text);
    if (userLogin != null) {
      emit(state.copyWith(status: RegisterStatus.success));
    } else {
      emit(state.copyWith(status: RegisterStatus.error));
    }
    return userLogin;
  }
}
