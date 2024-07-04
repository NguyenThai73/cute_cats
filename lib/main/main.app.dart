import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cat_lover/component/dialog.show.image.dart';
import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/main/chat/chat.cubit.dart';
import 'package:cat_lover/main/chat/chat.page.dart';
import 'package:cat_lover/main/top_cat/top.cat.page.dart';
import 'package:cat_lover/main/user/user.page.dart';
import 'package:cat_lover/userapp/user.app.cubit.dart';
import 'package:cat_lover/userapp/user.app.cubit.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'favorite_cat/favorite.cat.page.dart';
import 'home/home.cutbit.dart';
import 'home/home.page.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;
  bool playMusic = false;
  late AssetsAudioPlayer _assetsAudioPlayer;
  final audios = <Audio>[
    Audio(
      'assets/chill.mp3',
      metas: Metas(
        id: 'Chill',
        title: 'Chill',
        artist: 'Chill',
        album: 'Chill',
      ),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    playMusicAssets();
  }

  playMusicAssets() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: false,
      autoStart: true,
      loopMode: LoopMode.playlist,
      volume: 0.4
    );
    if(playMusic == false){
      _assetsAudioPlayer.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 40,
              backgroundColor: maincolor,
              leading: Row(
                children: [
                  BlocBuilder<UserAppCubit, UserAppCubitState>(
                    buildWhen: (previous, current) => previous.status != current.status,
                    builder: (context, state) {
                      return (state.userModel != null && state.userModel?.avatar != null)
                          ? GestureDetector(
                              onTap: () {
                                context.showImage(state.userModel!.avatar!);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 15),
                                width: 30,
                                height: 30,
                                child: CachedNetworkImage(
                                  imageUrl: state.userModel!.avatar ?? "",
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(left: 15),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/noavatar.png"),
                                    fit: BoxFit.cover,
                                  )),
                            );
                    },
                  )
                ],
              ),
              leadingWidth: 50,
              centerTitle: true,
              title: Text(
                currentIndex == 0
                    ? "Home"
                    : currentIndex == 1
                        ? "Ranking"
                        : currentIndex == 2
                            ? "Favorites"
                            : currentIndex == 3
                                ? "Community"
                                : currentIndex == 4
                                    ? "Account"
                                    : "",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        playMusic = !playMusic;
                      });
                      if (playMusic) {
                        _assetsAudioPlayer.play();
                      } else {
                        _assetsAudioPlayer.pause();
                      }
                    },
                    icon: playMusic
                        ? Icon(
                            Icons.music_note,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.music_off,
                            color: Colors.white,
                          )),
                SizedBox(width: 5)
              ],
            ),
            body: currentIndex == 0
                ? BlocProvider(
                    lazy: false,
                    create: (context) => HomeCubit(),
                    child: const HomePage(),
                  )
                : currentIndex == 2
                    ? const FavoriteCatPage()
                    : currentIndex == 3
                        ? BlocBuilder<UserAppCubit, UserAppCubitState>(
                            buildWhen: (previous, current) => previous.status != current.status,
                            builder: (context, state) {
                              return MultiBlocProvider(providers: [
                                BlocProvider(
                                  lazy: false,
                                  create: (context) => ChatCubit(userModel: state.userModel),
                                ),
                              ], child: const ChatPage());
                            },
                          )
                        : currentIndex == 4
                            ? const UserPage()
                            : const RankingPage(),
            bottomNavigationBar: Container(
              height: 96,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
              child: BottomNavigationBar(
                selectedItemColor: maincolor,
                unselectedItemColor: Colors.grey,
                currentIndex: currentIndex,
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.signal_cellular_alt),
                    label: 'Ranking',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    label: 'Community',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Account',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
