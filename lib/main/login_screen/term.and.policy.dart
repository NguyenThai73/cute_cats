import 'package:cat_lover/component/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TermAndPolicyScreen extends StatelessWidget {
  const TermAndPolicyScreen({super.key});

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
          "Terms and Policy",
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: InAppWebView(
            initialSettings: InAppWebViewSettings(),
            initialUrlRequest: URLRequest(url: WebUri("https://sites.google.com/view/cutecatscc/trang-ch%E1%BB%A7")),
          ),
    );
  }
}
