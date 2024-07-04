import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: const Color(0xFFe7dfde).withOpacity(0.5)),
        child: Center(
            child: Container(
          width: 123,
          height: 123,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200), image: const DecorationImage(image: AssetImage("assets/loading2.gif"), fit: BoxFit.cover)),
        )));
  }
}
