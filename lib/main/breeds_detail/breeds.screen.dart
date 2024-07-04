// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_lover/component/dialog.app.dart';
import 'package:cat_lover/component/list.state.dart';
import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/main/image_cat/image.cat.cubit.dart';
import 'package:cat_lover/main/image_cat/image.cat.page.dart';
import 'package:cat_lover/main/top_cat/top.cat.cubit.dart';
import 'package:cat_lover/main/top_cat/top.cat.cubit.state.dart';
import 'package:cat_lover/model/user.model.dart';
import 'package:cat_lover/userapp/user.app.cubit.dart';
import 'package:cat_lover/userapp/user.app.cubit.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'breeds.cubit.dart';
import 'breeds.cubit.state.dart';

class BreedsScreen extends StatelessWidget {
  const BreedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedsCubit, BreedsCubitState>(
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
            title: Text(
              state.breedsModel.name??"",
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              state.breedsModel.wikipedia_url != null && state.breedsModel.wikipedia_url != ""
                  ? InkWell(
                      onTap: () {
                        launchInBrowser(Uri.tryParse(state.breedsModel.wikipedia_url ?? "")!);
                      },
                      child: const Icon(
                        Icons.web,
                        color: Colors.white,
                      ))
                  : const SizedBox.shrink(),
              const SizedBox(width: 22)
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(
                  child: state.status != ListLoadStatus.loading
                      ? SingleChildScrollView(
                          controller: context.read<BreedsCubit>().scrollController,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: 150,
                                            height: 150,
                                            child: CachedNetworkImage(
                                              imageUrl: state.breedsModel.image?.url ?? "",
                                              errorWidget: (context, url, error) => Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: const DecorationImage(
                                                      image: AssetImage("assets/loading.gif"),
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              placeholder: (context, url) => Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: const DecorationImage(
                                                      image: AssetImage("assets/loading.gif"),
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              imageBuilder: (context, imageProvider) => Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              fit: BoxFit.cover,
                                            )),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("LIFESPAN", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                              Text("${state.breedsModel.life_span} years",
                                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                              const SizedBox(height: 15),
                                              const Text("WEIGHT", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                              Text("${state.breedsModel.weight?.metric} KG",
                                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                              const SizedBox(height: 15),
                                              const Text("ORIGIN", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                              Text("${state.breedsModel.origin}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                              const SizedBox(height: 15),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Text("temperament".toUpperCase(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                    Text("${state.breedsModel.temperament}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                    const SizedBox(height: 15),
                                    Text(
                                      "${state.breedsModel.description}",
                                      style: const TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                height: 760,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                        child: Column(
                                      children: [
                                        CustomCharateristios(title: "Adaptability", initialRating: (state.breedsModel.adaptability ?? 0).toDouble()),
                                        CustomCharateristios(title: "Social Needs", initialRating: (state.breedsModel.social_needs ?? 0).toDouble()),
                                        CustomCharateristios(
                                            title: "Health Issues", initialRating: (state.breedsModel.health_issues ?? 0).toDouble()),
                                        CustomCharateristios(title: "Dog Friendly", initialRating: (state.breedsModel.dog_friendly ?? 0).toDouble()),
                                        CustomCharateristios(title: "Energy Level", initialRating: (state.breedsModel.energy_level ?? 0).toDouble()),
                                        CustomCharateristios(
                                            title: "Shedding Level", initialRating: (state.breedsModel.shedding_level ?? 0).toDouble()),
                                        CustomCharateristios(
                                            title: "Stranger Friendly", initialRating: (state.breedsModel.stranger_friendly ?? 0).toDouble()),
                                        CustomCharateristios(title: "Intelligence", initialRating: (state.breedsModel.intelligence ?? 0).toDouble()),
                                        CustomCharateristios(
                                            title: "Child Friendly", initialRating: (state.breedsModel.child_friendly ?? 0).toDouble()),
                                        CustomCharateristios(title: "Grooming", initialRating: (state.breedsModel.grooming ?? 0).toDouble()),
                                        CustomCharateristios(
                                            title: "Affectionate", initialRating: (state.breedsModel.affection_level ?? 0).toDouble()),
                                        CustomCharateristios(title: "Vocalisation", initialRating: (state.breedsModel.vocalisation ?? 0).toDouble()),
                                      ],
                                    )),
                                    Positioned.fill(
                                      child: Container(
                                        height: 500,
                                        width: MediaQuery.of(context).size.width,
                                        color: Colors.grey.withOpacity(0.0),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: state.list
                                      .map((element) => SizedBox(
                                            width: (MediaQuery.of(context).size.width - 32 - 20) / 3,
                                            height: (MediaQuery.of(context).size.width - 32 - 20) / 3,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push<void>(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext context) => BlocProvider(
                                                      lazy: false,
                                                      create: (context) => ImageCatCubit(imageId: element.id ?? ""),
                                                      child: const ImageCatPage(),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl: element.url ?? "",
                                                errorWidget: (context, url, error) => Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      image: const DecorationImage(
                                                        image: AssetImage("assets/loading.gif"),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                placeholder: (context, url) => Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      image: const DecorationImage(
                                                        image: AssetImage("assets/loading.gif"),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                imageBuilder: (context, imageProvider) => Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              SizedBox(height: 85)
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
                        )),
              Positioned.fill(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<UserAppCubit, UserAppCubitState>(
                    builder: (context, stateUser) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocBuilder<TopCatCubit, TopCatCubitState>(
                            builder: (context, stateRanking) {
                              return Container(
                                width: 120,
                                height: 70,
                                margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: maincolor,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 10),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30), image: DecorationImage(image: AssetImage("assets/catcute.jpg"))),
                                    ),
                                    (stateRanking.listRankId.contains(state.breedsModel.id))
                                        ? Column(
                                            children: [
                                              SizedBox(height: 10),
                                              Text(
                                                "# ${stateRanking.listRankId.indexOf(state.breedsModel.id ?? "") + 1}",
                                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                                              ),
                                              Text(
                                                "${stateRanking.listRank[stateRanking.listRankId.indexOf(state.breedsModel.id ?? "")].fish ?? 0}",
                                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: const [
                                              SizedBox(height: 25),
                                              Text(
                                                "# NaN",
                                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              );
                            },
                          ),
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
                                    await context
                                        .read<TopCatCubit>()
                                        .acctionHandleRanking(breedsModel: state.breedsModel, userModelFeed: stateUser.userModel ?? UserModel());
                                    context.read<UserAppCubit>().updateUser(stateUser.userModel?.copyWith(first: fishNow - 1));
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 70,
                                margin: const EdgeInsets.only(bottom: 16, right: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: maincolor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 10),
                                    Image.asset(
                                      "assets/fish.gif",
                                      width: 50,
                                      height: 50,
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: const Text(
                                        "Feed the cat",
                                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}

class CustomCharateristios extends StatelessWidget {
  final String title;
  final double initialRating;
  const CustomCharateristios({
    super.key,
    required this.title,
    required this.initialRating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500, color: maincolor))),
        Expanded(
            // flex: 2,
            child: AnimatedRatingBar(
          activeFillColor: maincolor,
          strokeColor: Colors.red,
          initialRating: initialRating,
          height: 60,
          animationColor: Colors.red,
          onRatingUpdate: (rating) {},
        ))
      ],
    );
  }
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

class DialogComfiemFeed extends StatelessWidget {
  final int fishNow;
  const DialogComfiemFeed({super.key, required this.fishNow});

  @override
  Widget build(BuildContext context) {
    return DialogApp(
        child: Column(
      children: [
        Text(
          "You currently have $fishNow fish",
          style: TextStyle(fontSize: 20, color: maincolor, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), image: DecorationImage(image: AssetImage("assets/cat_fish.gif"), fit: BoxFit.cover)),
        ),
        Text(
          "Feeding the cat will cost you 1 fish. Please press continue!",
          style: TextStyle(fontSize: 17, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
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
                    color: maincolor,
                    border: Border.all(width: 2, color: maincolor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
