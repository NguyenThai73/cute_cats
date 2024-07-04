// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'dialog.app.dart';
import 'style.dart';

class ErrorDialogApp extends StatefulWidget {
  Widget? child;
  final String? message;
  ErrorDialogApp({super.key, this.child, this.message});

  @override
  State<ErrorDialogApp> createState() => _ErrorDialogAppState();
}

class _ErrorDialogAppState extends State<ErrorDialogApp> {
  @override
  Widget build(BuildContext context) {
    return DialogApp(
      clickOut: () {
        Navigator.pop(context);
      },
      child: widget.child ??
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.message ?? "An error occurred, please try again.",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      // width: 120,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: maincolor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text('OK', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                    )),
              ),
            ],
          ),
    );
  }
}
