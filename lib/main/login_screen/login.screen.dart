// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cat_lover/component/error.dart';
import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/main/block/block.cubit.dart';
import 'package:cat_lover/main/favorite_cat/favorite.cat.cubit.dart';
import 'package:cat_lover/main/login_screen/term.and.policy.dart';
import 'package:cat_lover/main/main.app.dart';
import 'package:cat_lover/main/top_cat/top.cat.cubit.dart';
import 'package:cat_lover/userapp/user.app.cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../component/loading.dart';
import '../register_screen/register.cubit.dart';
import '../register_screen/register.screen.dart';
import 'login.cubit.dart';
import 'login.cubit.state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSeenPass = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocConsumer<LoginCubit, LoginCubitState>(
        listener: (context, state) async {
          if (state.status == LoginStatus.success) {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const MainApp(),
              ),
            );
          }
          if (state.status == LoginStatus.error) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialogApp(
                message: "Account password is incorrect",
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.15,
                                  bottom: MediaQuery.of(context).size.height * 0.07,
                                ),
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20), image: const DecorationImage(image: AssetImage("assets/logo.png"))),
                              ),
                              SizedBox(height: 30),
                              Container(
                                margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                                padding: EdgeInsets.only(right: 10),
                                height: 56,
                                decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  controller: context.read<LoginCubit>().emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                                    prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.email, color: maincolor)),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 18),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                                padding: EdgeInsets.only(right: 10),
                                height: 56,
                                decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  controller: context.read<LoginCubit>().passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                                    prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.lock, color: maincolor)),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 18),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isSeenPass = !isSeenPass;
                                        });
                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Icon(isSeenPass ? Icons.visibility_off : Icons.visibility, size: 20, color: maincolor),
                                      ),
                                    ),
                                  ),
                                  obscureText: isSeenPass,
                                ),
                              ),
                              Container(
                                height: 60,
                                margin: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 10),
                                decoration: BoxDecoration(
                                  color: maincolor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    var user = await context.read<LoginCubit>().login();
                                    if (user != null) {
                                      context.read<FavoriteCatCubit>().getData(user.id ?? "");
                                      context.read<BlockCubit>().getData(user);
                                      context.read<TopCatCubit>().getData();
                                      await context.read<UserAppCubit>().updateUser(user);
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: "Do not have an account? ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF999999),
                                  ),
                                ),
                                TextSpan(
                                  text: "Register",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: maincolor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: maincolor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      var response = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => BlocProvider(
                                            create: (context) => RegisterCubit(),
                                            child: const RegisterScreen(),
                                          ),
                                        ),
                                      );
                                      if (response != null && response is String) {
                                        context.read<LoginCubit>().emailController.text = response;
                                      }
                                    },
                                ),
                              ])),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text.rich(
                                  TextSpan(style: TextStyle(fontSize: 16), children: [
                                    TextSpan(
                                      text: "By logging in, you agree to our ",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "terms and usage policy.",
                                      style: TextStyle(
                                          fontSize: 14, color: maincolor, decoration: TextDecoration.underline, decorationColor: maincolor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) => const TermAndPolicyScreen(),
                                            ),
                                          );
                                        },
                                    ),
                                  ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
              Positioned.fill(child: state.status == LoginStatus.loading ? const Loading() : const SizedBox.shrink())
            ],
          );
        },
      ),
    );
  }
}
