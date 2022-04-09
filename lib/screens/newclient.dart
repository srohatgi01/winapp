import 'package:drift/drift.dart' as d;
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:winapp/data/drift_database.dart';
import 'package:winapp/widgets/bds-appbar.dart';

class NewClientScreen extends StatelessWidget {
  const NewClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BdsAppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final database = Provider.of<ClientDao>(context, listen: false);
                const client = ClientsCompanion(
                  name: d.Value("Sarthak Rohatgi"),
                  email: d.Value("sarthak@email.com"),
                  phoneNumber: d.Value("1234567890"),
                );
                database.insertClient(client);
              },
              child: const Text('INSERT'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                final database = Provider.of<ClientDao>(context, listen: false);

                var clients = await database.getAllClients();
                print(clients);
              },
              child: const Text('FETCH'),
            ),
          ],
        ),
      ),
    );
  }
}
