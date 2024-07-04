import 'package:cat_lover/component/dialog.app.dart';
import 'package:flutter/material.dart';

class DialogEditTextProfile extends StatefulWidget {
  final String name;
  final int? maxLength;
  final String title;
  final int? maxLine;
  final int? minLine;
  const DialogEditTextProfile({super.key, required this.name, this.maxLength, required this.title, this.maxLine, this.minLine});

  @override
  State<DialogEditTextProfile> createState() => _DialogEditTextProfileState();
}

class _DialogEditTextProfileState extends State<DialogEditTextProfile> {
  TextEditingController textController = TextEditingController();
  String nameNew = "";
  @override
  void initState() {
    super.initState();
    textController.text = widget.name;
    nameNew = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return DialogApp(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Text(
              "Full name",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 1),
              // height: 40,
              decoration: BoxDecoration(border: Border.all(color: const Color(0xFF6C6B6B)), borderRadius: BorderRadius.circular(5)),
              child: TextField(
                controller: textController,
                maxLines: widget.maxLine,
                minLines: widget.minLine,
                decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5)),
                onChanged: (value) {
                  if (widget.maxLength != null) {
                    setState(() {
                      if (value.length <= widget.maxLength!) {
                        nameNew = value;
                      } else {
                        textController.text = nameNew;
                      }
                    });
                  }
                },
              ),
            ),
            (widget.maxLength != null)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${nameNew.length}/${widget.maxLength}",
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      )
                    ],
                  )
                : const SizedBox.shrink(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, nameNew);
              },
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xffF22E62), Color(0xffF27272)], // Mảng màu để tạo dốc
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Update",
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
