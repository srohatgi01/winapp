import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winapp/screens/browse.dart';
import 'package:winapp/screens/inventory.dart';
import 'package:winapp/screens/newclient.dart';
import 'package:winapp/screens/newinvoice.dart';
import 'package:winapp/widgets/bds-appbar.dart';
import 'package:winapp/widgets/homepage-cards.dart';

import 'data/drift_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => MyDatabase(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BdsAppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomePageCards(
              title: "Inventory",
              image: "assets/inventory.png",
              widget: InventoryScreen(),
            ),
            HomePageCards(
              title: "Clients",
              image: "assets/newclient.png",
              widget: NewClientScreen(),
            ),
            HomePageCards(
              title: "Invoice",
              image: "assets/invoice.png",
              widget: NewInvoiceScreen(),
            ),
            HomePageCards(
              title: "Browsing",
              image: "assets/browsing.png",
              widget: BrowseScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
