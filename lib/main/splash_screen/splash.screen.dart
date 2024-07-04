// ignore_for_file: use_build_context_synchronously

import 'package:cat_lover/controller/user.controller.dart';
import 'package:cat_lover/main/block/block.cubit.dart';
import 'package:cat_lover/main/favorite_cat/favorite.cat.cubit.dart';
import 'package:cat_lover/main/login_screen/login.cubit.dart';
import 'package:cat_lover/main/login_screen/login.screen.dart';
import 'package:cat_lover/main/main.app.dart';
import 'package:cat_lover/main/top_cat/top.cat.cubit.dart';
import 'package:cat_lover/userapp/user.app.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash.cubit.dart';
import 'splash.cubit.state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashCubitState>(
      listener: (context, state) async {
        if (state.status == SplashStatus.authen) {
          var userCurrent = await UserController().getCurrentUser();
          if (userCurrent != null) {
            context.read<FavoriteCatCubit>().getData(userCurrent.id ?? "");
            context.read<BlockCubit>().getData(userCurrent);
            context.read<TopCatCubit>().getData();
            await context.read<UserAppCubit>().updateUser(userCurrent);
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const MainApp(),
              ),
            );
          } else {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => BlocProvider(
                  create: (context) => LoginCubit(),
                  child: const LoginScreen(),
                ),
              ),
            );
          }
        } else {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => BlocProvider(
                create: (context) => LoginCubit(),
                child: const LoginScreen(),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), image: const DecorationImage(image: AssetImage("assets/logo.png"))),
          ),
        ),
      ),
    );
  }
}
