// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_lover/component/list.state.dart';
import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/main/breeds_detail/breeds.cubit.dart';
import 'package:cat_lover/model/breeds.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../breeds_detail/breeds.screen.dart';
import 'home.cutbit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, ListState<BreedsModel>>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          color: maincolor.withOpacity(0.1),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFFEFEAEA),
                      ),
                      padding: EdgeInsets.only(right: 10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            // find = true;
                          });
                        },
                        controller: context.read<HomeCubit>().textSearch,
                        decoration: InputDecoration(
                          hintText: "Search breeds",
                          helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                          prefixIcon: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(
                                Icons.search,
                                color: Color(0xFF999898),
                              )),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      context.read<HomeCubit>().search();
                    },
                    child: Container(
                      width: 85,
                      height: 50,
                      decoration: BoxDecoration(color: maincolor, borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          "Search",
                          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 10),
              Expanded(
                  child: state.status != ListLoadStatus.loading
                      ? state.list.isNotEmpty
                          ? GridView.builder(
                              controller: context.read<HomeCubit>().scrollController,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.8),
                              itemCount: state.list.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => BlocProvider(
                                        lazy: false,
                                        create: (context) => BreedsCubit(breedsModel: state.list[index]),
                                        child: const BreedsScreen(),
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: CachedNetworkImage(
                                        imageUrl: state.list[index].image?.url ?? "",
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
                                    Positioned.fill(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            state.list[index].name ?? "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              shadows: boderWhiteText,
                                            ),
                                          ),
                                          SizedBox(height: 5)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20, top: MediaQuery.of(context).size.height*0.1),
                                    width: 300,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("assets/nocat.png"), fit: BoxFit.cover),
                                    ),
                                  ),
                                  Text(
                                    "Not results",
                                    style: TextStyle(fontSize: 20, color: maincolor, fontWeight: FontWeight.w700),
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
                              image: DecorationImage(image: AssetImage("assets/loading1.gif"), fit: BoxFit.cover),
                            ),
                          ),
                        )),
              state.status == ListLoadStatus.loadmore
                  ? Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          image: const DecorationImage(image: AssetImage("assets/loading2.gif"), fit: BoxFit.cover)),
                    )
                  : SizedBox()
            ],
          ),
        );
      },
    );
  }
}

List<Shadow> boderWhiteText = [
  Shadow(
      // bottomLeft
      offset: Offset(-1.5, -1.5),
      color: Colors.white),
  Shadow(
      // bottomRight
      offset: Offset(1.5, -1.5),
      color: Colors.white),
  Shadow(
      // topRight
      offset: Offset(1.5, 1.5),
      color: Colors.white),
  Shadow(
      // topLeft
      offset: Offset(-1.5, 1.5),
      color: Colors.white),
];
