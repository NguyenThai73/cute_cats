// ignore_for_file: prefer_const_constructors

import 'package:cat_lover/component/error.dart';
import 'package:cat_lover/component/loading.dart';
import 'package:cat_lover/component/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register.cubit.dart';
import 'register.cubit.state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isSeenPass = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterCubitState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: maincolor,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
            title: const Text(
              "Create a new account",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                            ),
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), image: const DecorationImage(image: AssetImage("assets/logo.png"))),
                          ),
                          SizedBox(height: 30),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                            padding: EdgeInsets.only(right: 10),
                            height: 56,
                            decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: context.read<RegisterCubit>().nameController,
                              decoration: InputDecoration(
                                hintText: "Full name",
                                helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                                prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.person, color: maincolor)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 18),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                            padding: EdgeInsets.only(right: 10),
                            height: 56,
                            decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: context.read<RegisterCubit>().emailController,
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
                            margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                            padding: EdgeInsets.only(right: 10),
                            height: 56,
                            decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: context.read<RegisterCubit>().passwordController,
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
                            margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                            padding: EdgeInsets.only(right: 10),
                            height: 56,
                            decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: context.read<RegisterCubit>().rePasswordController,
                              decoration: InputDecoration(
                                hintText: "Comfirm password",
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
                          GestureDetector(
                            onTap: () async {
                              if (context.read<RegisterCubit>().nameController.text.isEmpty ||
                                  context.read<RegisterCubit>().emailController.text.isEmpty ||
                                  context.read<RegisterCubit>().passwordController.text.isEmpty ||
                                  context.read<RegisterCubit>().rePasswordController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => ErrorDialogApp(
                                    message: "Need to enter enough information",
                                  ),
                                );
                              } else {
                                if (context.read<RegisterCubit>().passwordController.text.length < 6 ||
                                    context.read<RegisterCubit>().rePasswordController.text.length < 6) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ErrorDialogApp(
                                      message: "Password must be greater than 5 characters",
                                    ),
                                  );
                                } else {
                                  if (context.read<RegisterCubit>().passwordController.text !=
                                      context.read<RegisterCubit>().rePasswordController.text) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ErrorDialogApp(
                                        message: "Confirm passwords do not match",
                                      ),
                                    );
                                  } else {
                                    var response = await context.read<RegisterCubit>().register();
                                    if (response != null) {
                                      Navigator.pop(context, context.read<RegisterCubit>().emailController.text);
                                    }
                                  }
                                }
                              }
                            },
                            child: Container(
                              height: 60,
                              margin: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 10),
                              decoration: BoxDecoration(
                                color: maincolor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(child: state.status == RegisterStatus.loading ? const Loading() : const SizedBox.shrink())
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
