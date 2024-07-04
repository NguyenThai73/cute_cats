// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/main/block/block.cubit.dart';
import 'package:cat_lover/main/block/block.cubit.state.dart';
import 'package:cat_lover/main/chat/chat.page.dart';
import 'package:cat_lover/userapp/user.app.cubit.dart';
import 'package:cat_lover/userapp/user.app.cubit.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'top.user.cubit.dart';
import 'top.user.cubit.state.dart';

class TopUserScreen extends StatelessWidget {
  const TopUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAppCubit, UserAppCubitState>(
      builder: (context, stateUser) {
        return BlocBuilder<TopUserCubit, TopUserCubitState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 40,
                backgroundColor: maincolor,
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                title: const Text(
                  "Top feeding",
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
              ),
              body: Container(
                color: maincolor.withOpacity(0.1),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: (state.status != TopUserStatus.loading)
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 24),
                            for (var i = 0; i < state.listUserFeed.length; i++)
                              Container(
                                width: MediaQuery.of(context).size.width - 32,
                                margin: EdgeInsets.only(bottom: 16),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ]),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "#${i + 1}",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 16),
                                    AvatarItem(userModel: state.listUserFeed[i].userModel, size: 80),
                                    SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BlocBuilder<BlockCubit, BlockCubitState>(
                                          builder: (context, stateBlock) {
                                            return Text(
                                              (stateBlock.listBlockId.contains(state.listUserFeed[i].userModel?.id ?? ""))
                                                  ? "Blocker"
                                                  : stateUser.userModel?.id == state.listUserFeed[i].userModel?.id
                                                      ? "You"
                                                      : state.listUserFeed[i].userModel?.name ?? "",
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          "Fish: ${state.listUserFeed[i].fish ?? 0}",
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      )
                    : Center(
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(300),
                            image: const DecorationImage(image: AssetImage("assets/loading1.gif"), fit: BoxFit.cover),
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
