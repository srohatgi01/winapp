import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:winapp/create_and_save_pdf.dart';
import 'package:winapp/data/drift_database.dart';
import 'package:winapp/widgets/bds-appbar.dart';

class NewInvoiceScreen extends StatefulWidget {
  NewInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  final TextEditingController _clientFieldController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Client> clients = [];
  Client? _selectedClient;

  late final database;
  late Stream<List> stream;

  List<Inventorie> _selectedInventories = [];

  @override
  void initState() {
    populate();
    database = Provider.of<MyDatabase>(context, listen: false);
    stream = database.inventoryDao.watchAllInventory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BdsAppBar(),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _clientFieldController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Select a Client',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () => _selectClientDialog(context),
                ),
              ),
              ElevatedButton(
                child: Container(
                  width: 270,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('Add Items from Inventory',
                      style: TextStyle(fontSize: 18)),
                ),
                onPressed: null,
              ),
              Container(
                width: 300,
                child: ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemCount: _selectedInventories.length,
                    itemBuilder: (context, index) =>
                        Text(_selectedInventories[index].itemName)),
              )
            ],
          ),
          Container(
            width: 500,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      stream = database.inventoryDao
                          .watchSearchByItemName(_searchController.value.text);
                    });
                  },
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: 'Search Inventory',
                    constraints: BoxConstraints(maxWidth: 600),
                  ),
                ),
                StreamBuilder(
                    stream: stream,
                    // initialData: [database.inventoryDao.watchAllInventory()],
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active &&
                          snapshot.hasData) {
                        List<Inventorie> inventory =
                            snapshot.data as List<Inventorie>;
                        return Expanded(
                          child: ListView.builder(
                            controller: ScrollController(),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) => Row(
                              children: [
                                Container(
                                  width: 500,
                                  child: ListTile(
                                    onTap: () {
                                      _selectedInventories
                                          .add(inventory[index]);
                                    },
                                    leading: Text(
                                      inventory[index].id.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    title: Text(
                                      inventory[index].itemName.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      "Rs " +
                                          inventory[index].itemPrice.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    trailing: Checkbox(
                                        key: Key(index.toString()),
                                        value: _selectedInventories
                                                .contains(inventory[index])
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value == true) {
                                              _selectedInventories
                                                  .add(inventory[index]);
                                            } else if (value == false) {
                                              _selectedInventories
                                                  .remove(inventory[index]);
                                            }
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            itemCount: inventory.length,
                          ),
                        );
                      } else {
                        return const Text("Something went wrong");
                      }
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _selectClientDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ListView.builder(
          itemBuilder: ((context, index) => ListTile(
                title: Text(clients[index].name),
                subtitle: Text(clients[index].phoneNumber),
                trailing: Text(clients[index].email),
                onTap: () {
                  _selectedClient = clients[index];
                  _clientFieldController.text = _selectedClient!.name;

                  // createAndSavePdf(mockData, _selectedClient!);

                  Navigator.pop(context);
                },
              )),
          itemCount: clients.length,
          shrinkWrap: true,
        ),
      ),
    );
  }

  void populate() async {
    clients = await Provider.of<MyDatabase>(context, listen: false)
        .clientDao
        .getAllClients();
  }

  final List<Map> mockData = [
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
