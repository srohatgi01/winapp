import 'package:flutter/material.dart';
import 'package:winapp/create_and_save_pdf.dart';

void main() {
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
    return Scaffold(
        // appBar: AppBar(title: const Text('MyHome Page')),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset("assets/bds-logo.png", width: 200),
          ElevatedButton(
            onPressed: () => createAndSavePdf(mockData),
            child: const Text('Press to create pdf'),
          ),
        ],
      ),
    ));
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
