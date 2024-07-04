import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/main/image_cat/image.cat.cubit.dart';
import 'package:cat_lover/main/image_cat/image.cat.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite.cat.cubit.dart';
import 'favorite.cat.cubit.state.dart';

class FavoriteCatPage extends StatelessWidget {
  const FavoriteCatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCatCubit, FavoriteCatCubitState>(
      builder: (context, state) {
        return state.listFavorite.isNotEmpty
            ? Container(
              color: maincolor.withOpacity(0.1),
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1),
                  itemCount: state.listFavorite.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => BlocProvider(
                            lazy: false,
                            create: (context) => ImageCatCubit(imageId: state.listFavorite[index].id ?? ""),
                            child: const ImageCatPage(),
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl: state.listFavorite[index].url ?? "",
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
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: MediaQuery.of(context).size.height * 0.1),
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/nocat.png"), fit: BoxFit.cover),
                      ),
                    ),
                    Text(
                      "Not results",
                      style: TextStyle(fontSize: 20, color: maincolor, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              );
      },
    );
  }
}
