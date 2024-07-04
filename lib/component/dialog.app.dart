import 'package:flutter/material.dart';

class DialogApp extends StatelessWidget {
  final Function? clickOut;
  final Widget child;
  const DialogApp({
    super.key,
    required this.child,
    this.clickOut,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (clickOut != null) {
                clickOut!();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: child),
              ],
            )),
      ),
    );
  }
}
