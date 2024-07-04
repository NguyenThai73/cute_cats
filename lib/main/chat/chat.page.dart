import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_lover/component/dialog.app.dart';
import 'package:cat_lover/component/dialog.show.image.dart';
import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/main/block/block.cubit.dart';
import 'package:cat_lover/main/block/block.cubit.state.dart';
import 'package:cat_lover/main/chat/chat.cubit.dart';
import 'package:cat_lover/model/user.model.dart';
import 'package:cat_lover/userapp/user.app.cubit.dart';
import 'package:cat_lover/userapp/user.app.cubit.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat.cubit.state.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isHasForbiddenWord = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAppCubit, UserAppCubitState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, stateUserApp) {
        return BlocBuilder<BlockCubit, BlockCubitState>(
          builder: (context, stateBlock) {
            return Column(
              children: [
                BlocBuilder<ChatCubit, ChatCubitState>(
                  builder: (context, state) {
                    return Expanded(
                      child: state.status != ChatStatus.loading
                          ? Container(
                              color: maincolor.withOpacity(0.1),
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: ListView.builder(
                                  reverse: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.listChat.length,
                                  itemBuilder: (context, index) {
                                    final itemChat = state.listChat[index];
                                    if (stateBlock.listBlockId.contains(itemChat.sendBy)) {
                                      return Container();
                                    }
                                    if (stateUserApp.userModel != null && stateUserApp.userModel?.id == itemChat.sendBy) {
                                      return Container(
                                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.55,
                                              margin: const EdgeInsets.only(left: 10, right: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(255, 255, 166, 170), borderRadius: BorderRadius.circular(8)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  itemChat.type == "text"
                                                      ? Text(
                                                          itemChat.content ?? "",
                                                          style: const TextStyle(color: Colors.black, fontSize: 15),
                                                        )
                                                      : Container(
                                                          height: 150,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              if (itemChat.content != null && itemChat.content != "") {
                                                                context.showImage(itemChat.content!);
                                                              }
                                                            },
                                                            child: CachedNetworkImage(
                                                              imageUrl: itemChat.content ?? "",
                                                              imageBuilder: (context, imageProvider) => Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                                                              ),
                                                              placeholder: (context, url) => Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    image: const DecorationImage(
                                                                        image: AssetImage("assets/loading5.gif"), fit: BoxFit.contain)),
                                                              ),
                                                              errorWidget: (context, url, error) => Container(),
                                                            ),
                                                          ),
                                                        ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    itemChat.time ?? "",
                                                    style: const TextStyle(fontSize: 10, color: Color.fromARGB(255, 78, 78, 78)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            AvatarItem(
                                              userModel: itemChat.user,
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AvatarItem(
                                              userModel: itemChat.user,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 2),
                                                    child: Text(
                                                      itemChat.user?.name ?? "",
                                                      style: const TextStyle(color: Colors.black, fontSize: 17),
                                                    )),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.55,
                                                  margin: const EdgeInsets.only(left: 10, right: 10),
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: const Color.fromARGB(255, 255, 166, 170), borderRadius: BorderRadius.circular(8)),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      itemChat.type == "text"
                                                          ? Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    itemChat.content ?? "",
                                                                    style: const TextStyle(color: Colors.black, fontSize: 15),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container(
                                                              height: 150,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  if (itemChat.content != null && itemChat.content != "") {
                                                                    context.showImage(itemChat.content!);
                                                                  }
                                                                },
                                                                child: CachedNetworkImage(
                                                                  imageUrl: itemChat.content ?? "",
                                                                  imageBuilder: (context, imageProvider) => Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(8),
                                                                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                                                                  ),
                                                                  placeholder: (context, url) => Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(8),
                                                                        image: const DecorationImage(
                                                                            image: AssetImage("assets/loading5.gif"), fit: BoxFit.contain)),
                                                                  ),
                                                                  errorWidget: (context, url, error) => Container(),
                                                                ),
                                                              ),
                                                            ),
                                                      const SizedBox(height: 10),
                                                      Text(
                                                        itemChat.time ?? "",
                                                        style: const TextStyle(fontSize: 10, color: Color.fromARGB(255, 78, 78, 78)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }),
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
                    );
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 5, top: 10, left: 16, right: 16),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          var fileName = await handleUploadImage();
                          if (fileName != null) {
                            context.read<ChatCubit>().sendImage(fileName);
                          }
                        },
                        behavior: HitTestBehavior.translucent,
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            isHasForbiddenWord = false;
                          });
                        },
                        autovalidateMode: AutovalidateMode.disabled,
                        controller: context.read<ChatCubit>().chatController,
                        style: const TextStyle(color: Colors.black, fontSize: 12, height: 1.0),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                            isCollapsed: true,
                            fillColor: const Color(0xFFF5F5F5),
                            filled: true,
                            hintText: '',
                            hintStyle: const TextStyle(color: Colors.black, fontSize: 12, height: 1.0)),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      BlocBuilder<ChatCubit, ChatCubitState>(
                        builder: (context, stateChat) {
                          return GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (context.read<ChatCubit>().chatController.text.isNotEmpty) {
                                if (checkForbiddenWord(stateChat.listForbiddenWord, context.read<ChatCubit>().chatController.text)) {
                                  setState(() {
                                    isHasForbiddenWord = true;
                                  });
                                } else {
                                  context.read<ChatCubit>().sendText();
                                  setState(() {
                                    isHasForbiddenWord = false;
                                  });
                                }
                              }
                            },
                            behavior: HitTestBehavior.translucent,
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.send,
                                  size: 24,
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                isHasForbiddenWord
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "The content you submit contains prohibited words",
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      )
                    : const SizedBox(height: 5)
              ],
            );
          },
        );
      },
    );
  }
}

bool checkForbiddenWord(List<String> listcheck, String content) {
  for (var element in listcheck) {
    var dataCheck = content.split(" ");
    for (var elementCheck in dataCheck) {
      if (element == elementCheck.toUpperCase()) {
        return true;
      }
    }
  }
  return false;
}

class AvatarItem extends StatelessWidget {
  final UserModel? userModel;
  final double? size;
  final bool? click;
  const AvatarItem({super.key, required this.userModel, this.size, this.click});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlockCubit, BlockCubitState>(
      builder: (context, stateBlock) {
        return BlocBuilder<UserAppCubit, UserAppCubitState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: stateBlock.listBlockId.contains(userModel?.id)
                  ? null
                  : () async {
                      if (state.userModel?.id == userModel?.id) {
                        if (userModel?.avatar != null && userModel?.avatar != "") {
                          context.showImage(userModel?.avatar ?? "");
                        }
                      } else {
                        var response = await showDialog(
                          context: context,
                          builder: (context) => DialogApp(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipOval(
                                      child: (userModel?.avatar != null)
                                          ? CachedNetworkImage(
                                              imageUrl: userModel?.avatar ?? "",
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) {
                                                return Image.asset(
                                                  "assets/noavatar.png",
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            )
                                          : Image.asset(
                                              "assets/noavatar.png",
                                              fit: BoxFit.cover,
                                            )),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  userModel?.name ?? "",
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: Container(
                                            width: 120,
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: maincolor,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child:
                                                const Text('Block', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                        if (response != null && response is bool && response == true) {
                          context.read<BlockCubit>().handleBlock(userModel: userModel ?? UserModel());
                        }
                      }
                    },
              child: SizedBox(
                width: size ?? 40,
                height: size ?? 40,
                child: ClipOval(
                    child: stateBlock.listBlockId.contains(userModel?.id)
                        ? Image.asset(
                            "assets/noavatar.png",
                            fit: BoxFit.cover,
                          )
                        : (userModel?.avatar != null)
                            ? CachedNetworkImage(
                                imageUrl: userModel?.avatar ?? "",
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) {
                                  return Image.asset(
                                    "assets/noavatar.png",
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                "assets/noavatar.png",
                                fit: BoxFit.cover,
                              )),
              ),
            );
          },
        );
      },
    );
  }
}
