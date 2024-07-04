import 'package:cat_lover/component/error.dart';
import 'package:cat_lover/component/style.dart';
import 'package:cat_lover/main/buy_fish/buy.fish.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../userapp/user.app.cubit.dart';
import '../../userapp/user.app.cubit.state.dart';
import 'buy.fish.cubit.state.dart';

class BuyFishScreen extends StatefulWidget {
  const BuyFishScreen({super.key});

  @override
  State<BuyFishScreen> createState() => _BuyFishScreenState();
}

class _BuyFishScreenState extends State<BuyFishScreen> {
  int fishAdd = 0;
  @override
  Widget build(BuildContext context) {
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
          "Buy fish",
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<BuyFishCubit, BuyFishCubitState>(
        listener: (context, state) {
          if (state.status == BuyFishStatus.success) {
            context.read<UserAppCubit>().addFish(fishAdd);
          }
          if (state.status == BuyFishStatus.error) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialogApp(
                message: "Error",
              ),
            );
          }
        },
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        BlocBuilder<UserAppCubit, UserAppCubitState>(
                          builder: (context, stateUser) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFE3E3),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(width: 1, color: Colors.white),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Fish  ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF100F0F),
                                              height: 19.6 / 14,
                                              letterSpacing: 0.0025),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "${stateUser.userModel?.first ?? 0}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFFFC5F5F),
                                              height: 19.6 / 14,
                                              letterSpacing: 0.0025),
                                          textAlign: TextAlign.center,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(left: 8),
                                          width: 24,
                                          height: 24,
                                          child: Image.asset("assets/icon_heart.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        ...listBuyOption.map((element) => Container(
                              // height: 103,
                              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [
                                BoxShadow(offset: const Offset(0, 4), blurRadius: 12, color: const Color(0xFF333333).withOpacity(0.1))
                              ]),
                              child: GestureDetector(
                                onTap: () {
                                  fishAdd = element.getTotalPoint();
                                  context.read<BuyFishCubit>().purchaseProduct(element);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 103,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [Color(0xFFFF5282), Color(0xFFF28367)],
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          (element.bonus != null && element.bonus! > 0)
                                              ? Container(
                                                  margin: const EdgeInsets.only(bottom: 4),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "${element.fish ?? 0}",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          height: 20 / 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white,
                                                          decoration: TextDecoration.lineThrough,
                                                          decorationColor: Colors.white,
                                                        ),
                                                      ),
                                                      Container(
                                                        constraints: const BoxConstraints(
                                                          minHeight: 32,
                                                          minWidth: 32,
                                                        ),
                                                        padding: const EdgeInsets.only(top: 11, bottom: 11, left: 3, right: 3),
                                                        margin: const EdgeInsets.only(left: 8),
                                                        decoration: const BoxDecoration(
                                                            image:
                                                                DecorationImage(image: AssetImage("assets/icon_show_bonus.png"), fit: BoxFit.fill)),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "+${element.bonus}",
                                                              style: const TextStyle(
                                                                  color: Color(0xFFFC5F5F), fontSize: 10, height: 1.5, fontWeight: FontWeight.w500),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${element.getTotalPoint()}",
                                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, height: 25 / 18),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(left: 6),
                                                width: 30,
                                                height: 30,
                                                child: Image.asset("assets/icon_heart.png"),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Center(
                                      child: GradientText("${element.amount ?? 0} \$",
                                          gradient: const LinearGradient(colors: [
                                            Color(0xFFC471F2),
                                            Color(0xFFF76CC6),
                                          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 40, height: 31 / 24)),
                                    ))
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                    child: (state.status == BuyFishStatus.loading)
                        ? Container(
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)), child: const Center(child: CircularProgressIndicator()))
                        : const SizedBox())
              ],
            ),
          );
        },
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, textAlign: TextAlign.center, style: style),
    );
  }
}
