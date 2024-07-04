// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_lover/component/dialog.show.image.dart';
import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/main/breeds_detail/breeds.cubit.dart';
import 'package:cat_lover/main/breeds_detail/breeds.screen.dart';
import 'package:cat_lover/model/breeds.model.dart';
import 'package:cat_lover/userapp/user.app.cubit.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user.model.dart';
import '../../userapp/user.app.cubit.dart';
import '../top_user/top.user.cubit.dart';
import '../top_user/top.user.screen.dart';
import 'top.cat.cubit.dart';
import 'top.cat.cubit.state.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("width: ${MediaQuery.of(context).size.width}");
    print("height: ${MediaQuery.of(context).size.height}");
    return BlocBuilder<TopCatCubit, TopCatCubitState>(
      builder: (context, state) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: maincolor.withOpacity(0.1),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    height: MediaQuery.of(context).size.height > 1000 ? 800 : 465,
                    width: MediaQuery.of(context).size.width - 32,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF333333).withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 12,
                        offset: const Offset(0, 4), // changes position of shadow
                      ),
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height > 1000 ? 615 : 280,
                          width: MediaQuery.of(context).size.width - 32,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: GestureDetector(
                                  onTap: () {
                                    context.showImage(state.listRank.first.image ?? "");
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: state.listRank.first.image ?? "",
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      width: 80,
                                      height: 80,
                                      decoration:
                                          BoxDecoration(border: Border.all(width: 2, color: maincolor), borderRadius: BorderRadius.circular(50)),
                                      child: ClipOval(
                                        child: Image.asset(
                                          "assets/top1.jpeg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            state.listRank.first.name ?? "",
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            "Origin: ${state.listRank.first.origin}",
                            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ),
                        BlocBuilder<UserAppCubit, UserAppCubitState>(
                          builder: (context, stateUser) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        var fishNow = stateUser.userModel?.first ?? 0;
                                        var response = await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DialogComfiemFeed(fishNow: fishNow);
                                            });
                                        if (response != null && response == true) {
                                          if (fishNow > 0) {
                                            await context.read<TopCatCubit>().acctionHandleRanking(
                                                breedsModel: BreedsModel(id: state.listRank.first.breedsId),
                                                userModelFeed: stateUser.userModel ?? UserModel());
                                            context.read<UserAppCubit>().updateUser(stateUser.userModel?.copyWith(first: fishNow - 1));
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration:
                                            BoxDecoration(border: Border.all(width: 1, color: maincolor), borderRadius: BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 10),
                                            Image.asset(
                                              "assets/fish.gif",
                                              width: 30,
                                              height: 30,
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              child: Text(
                                                "Feed the cat",
                                                style: TextStyle(fontSize: 14, color: maincolor, fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) => BlocProvider(
                                              lazy: false,
                                              create: (context) => TopUserCubit(rankingModel: state.listRank.first),
                                              child: const TopUserScreen(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration:
                                            BoxDecoration(border: Border.all(width: 1, color: maincolor), borderRadius: BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 10),
                                            Image.asset(
                                              "assets/top_user.png",
                                              width: 30,
                                              height: 30,
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              child: Text(
                                                "Top feeding",
                                                style: TextStyle(fontSize: 14, color: maincolor, fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => BlocProvider(
                                        lazy: false,
                                        create: (context) => BreedsCubit(breedsModel: BreedsModel(id: state.listRank.first.breedsId)),
                                        child: const BreedsScreen(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 16, right: 16),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [maincolor, const Color.fromARGB(255, 255, 163, 163)])),
                                  child: const Center(
                                    child: Text(
                                      "View breed",
                                      style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      for (int i = 1; i < state.listRank.length; i++)
                        Container(
                            height: MediaQuery.of(context).size.height > 1000 ? 500 : 350,
                            width: (MediaQuery.of(context).size.width - 50) / 2,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF333333).withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 12,
                                offset: const Offset(0, 4), // changes position of shadow
                              ),
                            ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height > 1000 ? 330 : 180,
                                  width: (MediaQuery.of(context).size.width - 50) / 2,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: GestureDetector(
                                          onTap: () {
                                            context.showImage(state.listRank[i].image ?? "");
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: state.listRank[i].image ?? "",
                                            fit: BoxFit.cover,
                                            imageBuilder: (context, imageProvider) => Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            (i == 1)
                                                ? Container(
                                                    margin: const EdgeInsets.all(10),
                                                    width: 55,
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(width: 2, color: maincolor), borderRadius: BorderRadius.circular(50)),
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        "assets/top2.jpeg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                                : (i == 2)
                                                    ? Container(
                                                        margin: const EdgeInsets.all(10),
                                                        width: 55,
                                                        height: 55,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(width: 2, color: maincolor), borderRadius: BorderRadius.circular(50)),
                                                        child: ClipOval(
                                                          child: Image.asset(
                                                            "assets/top3.jpeg",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 55,
                                                        height: 55,
                                                        margin: const EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(width: 2, color: maincolor),
                                                            borderRadius: BorderRadius.circular(50)),
                                                        child: Center(
                                                          child: Text(
                                                            "#${i + 1}",
                                                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: maincolor),
                                                          ),
                                                        ),
                                                      )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 4, right: 10),
                                  child: FittedBox(
                                    child: Text(
                                      state.listRank[i].name ?? "",
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 4),
                                  child: Text(
                                    "Origin: ${state.listRank[i].origin}",
                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                ),
                                BlocBuilder<UserAppCubit, UserAppCubitState>(
                                  builder: (context, stateUser) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                var fishNow = stateUser.userModel?.first ?? 0;
                                                var response = await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return DialogComfiemFeed(fishNow: fishNow);
                                                    });
                                                if (response != null && response == true) {
                                                  if (fishNow > 0) {
                                                    await context.read<TopCatCubit>().acctionHandleRanking(
                                                        breedsModel: BreedsModel(id: state.listRank[i].breedsId),
                                                        userModelFeed: stateUser.userModel ?? UserModel());
                                                    context.read<UserAppCubit>().updateUser(stateUser.userModel?.copyWith(first: fishNow - 1));
                                                  }
                                                }
                                              },
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(width: 1, color: maincolor), borderRadius: BorderRadius.circular(20)),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    Image.asset(
                                                      "assets/fish.gif",
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                    const SizedBox(width: 10),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push<void>(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext context) => BlocProvider(
                                                      lazy: false,
                                                      create: (context) => TopUserCubit(rankingModel: state.listRank[i]),
                                                      child: const TopUserScreen(),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(width: 1, color: maincolor), borderRadius: BorderRadius.circular(20)),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    Image.asset(
                                                      "assets/top_user.png",
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                    const SizedBox(width: 10),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) => BlocProvider(
                                                lazy: false,
                                                create: (context) => BreedsCubit(breedsModel: BreedsModel(id: state.listRank[i].breedsId)),
                                                child: const BreedsScreen(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 10, right: 10),
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [maincolor, const Color.fromARGB(255, 255, 163, 163)])),
                                          child: const Center(
                                            child: Text(
                                              "View breed",
                                              style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
