import 'package:flutter/material.dart';

class ShowFavoriteComponent extends StatelessWidget {
  final String title;
  final List<String> listData;
  final Function() onTap;
  const ShowFavoriteComponent({super.key, required this.title, required this.onTap, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 95,
          child: Text(
            title,
            style: const TextStyle(fontSize: 12, color: Color(0xFF857A7A)),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              height: 20,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                  itemCount: listData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          index == listData.length - 1 ? listData[index] : "${listData[index]}, ",
                          style: const TextStyle(color: Color(0xFFFC5F5F), fontSize: 14, fontWeight: FontWeight.w500),
                        ));
                  }),
            )),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient:
                    const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xFFFF5282), Color(0xFFF28367)])),
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}
