import 'package:drift/drift.dart' as d;
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:winapp/data/drift_database.dart';
import 'package:winapp/widgets/bds-appbar.dart';

class NewClientScreen extends StatelessWidget {
  NewClientScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<ClientDao>(context, listen: false);
    return Scaffold(
      appBar: const BdsAppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/newclient.png", width: 150),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Full Name',
                  constraints: BoxConstraints(maxWidth: 300),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Contact Number',
                  constraints: BoxConstraints(maxWidth: 300),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email Address',
                  constraints: BoxConstraints(maxWidth: 300),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Container(
                  width: 270,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('Add New Client',
                      style: TextStyle(fontSize: 18)),
                ),
                onPressed: () {
                  if (_emailController.text.isNotEmpty &&
                      _nameController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty) {
                    final database =
                        Provider.of<ClientDao>(context, listen: false);
                    final client = ClientsCompanion(
                      name: d.Value(_nameController.text),
                      email: d.Value(_emailController.text),
                      phoneNumber: d.Value(_phoneController.text),
                    );
                    database.insertClient(client).then((value) => {
                          _nameController.clear(),
                          _emailController.clear(),
                          _phoneController.clear(),
                        });
                  } else {
                    showDialog(
                        builder: (context) => const AlertDialog(
                            title: Text("Fields Cannot be Empty")),
                        context: context);
                  }
                },
              )
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Center(
                  child: Text("Existing Clients",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                ),
                StreamBuilder(
                  stream: database.watchAllClients(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active &&
                        snapshot.hasData) {
                      List<Client> clients = snapshot.data as List<Client>;
                      return ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ListTile(
                          subtitle: Text(
                            clients[index].phoneNumber.toString(),
                          ),
                          title: Text(
                            clients[index].name.toString(),
                          ),
                          trailing: Text(
                            clients[index].email.toString(),
                          ),
                          leading: Text(
                            clients[index].id.toString(),
                          ),
                        ),
                        itemCount: clients.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      );
                    } else {
                      return const Text("Something isn't right");
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
