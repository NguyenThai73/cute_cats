// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_lover/component/dialog.app.dart';
import 'package:cat_lover/component/dialog.show.image.dart';
import 'package:cat_lover/component/error.dart';
import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/controller/user.controller.dart';
import 'package:cat_lover/main/block/block.cubit.dart';
import 'package:cat_lover/main/buy_fish/buy.fish.cubit.dart';
import 'package:cat_lover/main/buy_fish/buy.fish.screen.dart';
import 'package:cat_lover/main/chat/chat.cubit.dart';
import 'package:cat_lover/main/favorite_cat/favorite.cat.cubit.dart';
import 'package:cat_lover/main/login_screen/login.cubit.dart';
import 'package:cat_lover/main/login_screen/login.screen.dart';
import 'package:cat_lover/main/top_cat/top.cat.cubit.dart';
import 'package:cat_lover/main/user/component/dialog.change.pass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../userapp/user.app.cubit.dart';
import '../../userapp/user.app.cubit.state.dart';
import 'component/button.edit.dart';
import 'component/dialog.edit.text.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAppCubit, UserAppCubitState>(
      builder: (context, state) {
        return Container(
          color: maincolor.withOpacity(0.1),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fullname: ${state.userModel?.name}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1),
                    ),
                    const SizedBox(width: 10),
                    ButtonEdit(
                      onTap: () async {
                        var response = await showDialog(
                          context: context,
                          builder: (context) => DialogEditTextProfile(
                            name: state.userModel?.name ?? "",
                            maxLength: 32,
                            title: "",
                            maxLine: 1,
                          ),
                        );
                        if (response != null && response is String && response.isNotEmpty && response != state.userModel?.name) {
                          context.read<UserAppCubit>().updateName(response);
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.width - 32) * 0.816,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: state.userModel?.avatar != null && state.userModel?.avatar != ""
                            ? GestureDetector(
                                onTap: () {
                                  context.showImage(state.userModel?.avatar ?? "");
                                },
                                child: CachedNetworkImage(
                                    imageUrl: state.userModel?.avatar ?? "",
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            image: const DecorationImage(
                                              image: AssetImage("assets/noavatar.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    placeholder: (context, url) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            image: DecorationImage(
                                              image: AssetImage("assets/loading4.gif"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/noavatar.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var fileName = await handleUploadImage();
                                    if (fileName != null) {
                                      context.read<UserAppCubit>().updateAvatar(fileName);
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 20,
                                    margin: const EdgeInsets.only(right: 17, bottom: 11),
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xFFFF5282), Color(0xFFF28367)]),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.photo_camera,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Upload",
                                            style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(color: Color.fromARGB(255, 255, 214, 214), borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 95,
                            child: Text(
                              "Email",
                              style: const TextStyle(fontSize: 16, color: Color(0xFF857A7A)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              state.userModel?.email ?? "",
                              style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          child: const Divider(
                            height: 0.5,
                            color: Color(0xFFFD9B9B),
                          )),
                      Row(
                        children: [
                          SizedBox(
                            width: 95,
                            child: Text(
                              "Fish",
                              style: const TextStyle(fontSize: 16, color: Color(0xFF857A7A)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "${state.userModel?.first ?? 0}",
                              style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var response = await showDialog(
                      context: context,
                      builder: (context) => const DialogChangePassword(),
                    );
                    if (response != null && response is String && response.isNotEmpty) {
                      var result = await context.read<UserAppCubit>().updatePassword(response);
                      if (result) {
                        showDialog(
                          context: context,
                          builder: (context) => ErrorDialogApp(
                            message: "Change password successfully",
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [maincolor, const Color.fromARGB(255, 255, 163, 163)])),
                    child: const Center(
                      child: Text(
                        "Change password",
                        style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => BlocProvider(
                          create: (context) => BuyFishCubit(),
                          child: const BuyFishScreen(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [maincolor, const Color.fromARGB(255, 255, 163, 163)])),
                    child: const Center(
                      child: Text(
                        "Buy fish",
                        style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                    onTap: () async {
                      context.read<FavoriteCatCubit>().cleanData();
                      context.read<BlockCubit>().cleanData();
                      context.read<TopCatCubit>().cleanData();
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => BlocProvider(
                            create: (context) => LoginCubit(),
                            child: const LoginScreen(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white, border: Border.all(width: 1, color: maincolor), borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            Icon(Icons.logout, color: maincolor, size: 30),
                            const SizedBox(width: 10),
                            Flexible(
                                child: Text(
                              "Logout",
                              style: TextStyle(fontSize: 17, color: maincolor, fontWeight: FontWeight.w700),
                            )),
                            const SizedBox(width: 10),
                          ],
                        ))),
                SizedBox(height: 16),
                GestureDetector(
                    onTap: () async {
                      var responseDelete = await showDialog(
                        context: context,
                        builder: (context) => DialogApp(
                            child: Column(
                          children: [
                            Text(
                              "When you delete your account, all your information will be deleted from our database, are you sure?",
                              style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: maincolor),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(fontSize: 16, color: maincolor, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(width: 2, color: Colors.red),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      );
                      if (responseDelete != null && responseDelete == true) {
                        await UserController().deleteAccount();
                        context.read<FavoriteCatCubit>().cleanData();
                        context.read<BlockCubit>().cleanData();
                        context.read<TopCatCubit>().cleanData();
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.clear();
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
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.red, border: Border.all(width: 1, color: Colors.red), borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            Icon(Icons.delete_forever, color: Colors.white, size: 30),
                            const SizedBox(width: 10),
                            Flexible(
                                child: Text(
                              "Delete account",
                              style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
                            )),
                            const SizedBox(width: 10),
                          ],
                        ))),
                SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
