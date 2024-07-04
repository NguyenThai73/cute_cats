import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/main/breeds_detail/breeds.cubit.dart';
import 'package:cat_lover/main/breeds_detail/breeds.screen.dart';
import 'package:cat_lover/main/favorite_cat/favorite.cat.cubit.dart';
import 'package:cat_lover/main/favorite_cat/favorite.cat.cubit.state.dart';
import 'package:cat_lover/model/breeds.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

import 'image.cat.cubit.dart';
import 'image.cat.cubitt.state.dart';

class ImageCatPage extends StatelessWidget {
  const ImageCatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCatCubit, ImageCatCubitState>(
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
            actions: [
              BlocBuilder<FavoriteCatCubit, FavoriteCatCubitState>(
                builder: (context, stateFavorites) {
                  return InkWell(
                      onTap: () {
                        context.read<FavoriteCatCubit>().acctionFavorites(imageModel: state.imageModel);
                      },
                      child: Icon(
                        Icons.favorite,
                        color: stateFavorites.listId.contains(state.imageModel.id ?? "") ? Colors.red : Colors.white,
                      ));
                },
              ),
              const SizedBox(width: 22)
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(
                  child: state.status != ImageCatStatus.loading
                      ? HeroPhotoViewRouteWrapper(
                          imageProvider: NetworkImage(
                            state.imageModel.url ?? "",
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
                        Positioned.fill(child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => BlocProvider(
                                        lazy: false,
                                        create: (context) => BreedsCubit(breedsModel: BreedsModel(id: state.imageModel.breeds.first.id)),
                                        child: const BreedsScreen(),
                                      ),
                                    ),
                                  );
                              },
                              child: Container(
                                width: 200,
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
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        "View breed",
                                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
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

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    super.key,
    required this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        maxScale: maxScale,
        heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
      ),
    );
  }
}
