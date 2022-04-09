import 'package:flutter/material.dart';

class HomePageCards extends StatelessWidget {
  const HomePageCards(
      {Key? key,
      required this.title,
      required this.image,
      required this.widget})
      : super(key: key);
  final String title;
  final String image;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          // border: Border.all(),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Image.asset(image, width: 100),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
