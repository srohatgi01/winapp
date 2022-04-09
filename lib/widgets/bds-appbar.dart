import 'package:flutter/material.dart';

class BdsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BdsAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _BdsAppBarState createState() => _BdsAppBarState();
}

class _BdsAppBarState extends State<BdsAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 2,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/bds-logo.png", fit: BoxFit.scaleDown, width: 50),
          const SizedBox(width: 10),
          const Text("Bharat Diesel Service", style: TextStyle(fontSize: 30))
        ],
      ),
    );
  }
}
