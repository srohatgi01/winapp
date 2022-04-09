import "package:flutter/material.dart";
import 'package:winapp/widgets/bds-appbar.dart';

class NewInvoiceScreen extends StatelessWidget {
  const NewInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BdsAppBar(),
      body: Container(
        alignment: Alignment.center,
        child: const Text("New Invoice Screen"),
      ),
    );
  }
}
