import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:winapp/create_and_save_pdf.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    database();
    return Scaffold(
      body: Container(),
    );
  }
  
  void database() async {
    var box = await Hive.openBox('testBox');
    box.put('name', "Sarthak");
    print(box.get('name'));
  }

  List<Map> mockData = [
    {"id": 01, "desc": "Some Car Part", "amount": 3000},
    {"id": 02, "desc": "Some Car Part", "amount": 3000},
    {"id": 03, "desc": "Some Car Part", "amount": 3000},
    {"id": 04, "desc": "Some Car Part", "amount": 3000},
    {"id": 05, "desc": "Some Car Part", "amount": 3000},
    {"id": 06, "desc": "Some Car Part", "amount": 3000},
    {"id": 07, "desc": "Some Car Part", "amount": 3000},
    {"id": 08, "desc": "Some Car Part", "amount": 3000},
    {"id": 09, "desc": "Some Car Part", "amount": 3000},
    {"id": 01, "desc": "Some Car Part", "amount": 3000},
    {"id": 02, "desc": "Some Car Part", "amount": 3000},
    {"id": 03, "desc": "Some Car Part", "amount": 3000},
    {"id": 04, "desc": "Some Car Part", "amount": 3000},
    {"id": 05, "desc": "Some Car Part", "amount": 3000},
    {"id": 06, "desc": "Some Car Part", "amount": 3000},
    {"id": 07, "desc": "Some Car Part", "amount": 3000},
    {"id": 08, "desc": "Some Car Part", "amount": 3000},
    {"id": 09, "desc": "Some Car Part", "amount": 3000},
    {"id": 01, "desc": "Some Car Part", "amount": 3000},
    {"id": 02, "desc": "Some Car Part", "amount": 3000},
    {"id": 03, "desc": "Some Car Part", "amount": 3000},
    {"id": 04, "desc": "Some Car Part", "amount": 3000},
    {"id": 05, "desc": "Some Car Part", "amount": 3000},
    {"id": 06, "desc": "Some Car Part", "amount": 3000},
    {"id": 07, "desc": "Some Car Part", "amount": 3000},
    {"id": 08, "desc": "Some Car Part", "amount": 3000},
    {"id": 09, "desc": "Some Car Part", "amount": 3000},
    {"id": 05, "desc": "Some Car Part", "amount": 3000},
    {"id": 06, "desc": "Some Car Part", "amount": 3000},
  ];
}
