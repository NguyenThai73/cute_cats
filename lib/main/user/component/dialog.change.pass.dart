// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:cat_lover/component/dialog.app.dart';
import 'package:cat_lover/component/error.dart';
import 'package:cat_lover/component/style.dart';
import 'package:flutter/material.dart';

class DialogChangePassword extends StatefulWidget {
  const DialogChangePassword({super.key});

  @override
  State<DialogChangePassword> createState() => _DialogChangePasswordState();
}

class _DialogChangePasswordState extends State<DialogChangePassword> {
  TextEditingController pass = TextEditingController();
  TextEditingController passComfirm = TextEditingController();
  bool isSeenPass = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DialogApp(
      child: Container(
        child: Column(
          children: [
            Text(
              "Change password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: maincolor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 20),
              padding: EdgeInsets.only(right: 10),
              height: 56,
              decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                  hintText: "Password",
                  helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                  prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.lock)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 18),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSeenPass = !isSeenPass;
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Icon(
                        isSeenPass ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                obscureText: isSeenPass,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(right: 10),
              height: 56,
              decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: passComfirm,
                decoration: InputDecoration(
                  hintText: "Password confirm",
                  helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                  prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.lock)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 18),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSeenPass = !isSeenPass;
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Icon(
                        isSeenPass ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                obscureText: isSeenPass,
              ),
            ),
            Center(
              child: GestureDetector(
                  onTap: () {
                    if (pass.text.isEmpty || passComfirm.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => ErrorDialogApp(
                          message: "Need to enter enough information",
                        ),
                      );
                    } else {
                      if (pass.text.length < 6 || passComfirm.text.length < 6) {
                        showDialog(
                          context: context,
                          builder: (context) => ErrorDialogApp(
                            message: "Password must be greater than 5 characters",
                          ),
                        );
                      } else {
                        if (pass.text != passComfirm.text) {
                          showDialog(
                            context: context,
                            builder: (context) => ErrorDialogApp(
                              message: "Confirm passwords do not match",
                            ),
                          );
                        } else {
                          Navigator.pop(context, pass.text);
                        }
                      }
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text('OK', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
