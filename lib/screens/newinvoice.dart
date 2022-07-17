import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:winapp/create_and_save_pdf.dart';
import 'package:winapp/data/drift_database.dart';
import 'package:winapp/data/models/invoice_items.dart';
import 'package:winapp/widgets/bds-appbar.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  final TextEditingController _clientFieldController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Client> clients = [];
  Client? _selectedClient;
  final List<InvoiceItems> _selectedInventories = [];

  late final database;
  late Stream<List> stream;

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Select Items from Inventory Column
          SizedBox(
            width: 400,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  // width: 200,
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Select Inventory to Add",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
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
                    constraints: BoxConstraints(maxWidth: 400),
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
                                SizedBox(
                                  width: 400,
                                  child: ListTile(
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
                                      "USD " +
                                          inventory[index].itemPrice.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    trailing: Checkbox(
                                        value: _selectedInventories.contains(
                                                InvoiceItems(
                                                    inventorie:
                                                        inventory[index]))
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value == true) {
                                              var i = InvoiceItems(
                                                  inventorie: inventory[index]);
                                              i.price = double.parse(
                                                  inventory[index].itemPrice);
                                              _selectedInventories.add(i);
                                            } else if (value == false) {
                                              _selectedInventories.remove(
                                                  InvoiceItems(
                                                      inventorie:
                                                          inventory[index]));
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
          // Selected Services List
          SizedBox(
            width: 450,
            child: ListView(
              children: [
                Container(
                  width: 300,
                  color: Colors.grey.shade300,
                  child: ListTile(
                    title: Text("Item Name"),
                    subtitle: Text("Item Price"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("New Price"),
                        SizedBox(width: 30),
                        Text("Quantity"),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 450,
                  child: ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemCount: _selectedInventories.length,
                    itemBuilder: (context, index) => ListTile(
                      title:
                          Text(_selectedInventories[index].inventorie.itemName),
                      subtitle: Text("USD " +
                          _selectedInventories[index].inventorie.itemPrice),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // For Price
                          SizedBox(
                              width: 50,
                              child: TextFormField(
                                  initialValue: _selectedInventories[index]
                                      .inventorie
                                      .itemPrice,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    if (value.length > 1) {
                                      if (double.tryParse(value) != null) {
                                        if (int.parse(value) > 1) {
                                          _selectedInventories[index].price =
                                              double.parse(value);
                                        }
                                      }
                                    }
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (value) {
                                    if (double.tryParse(value!) == null) {
                                      return "Invalid";
                                    }
                                  })),
                          SizedBox(width: 30),
                          // For Quantity
                          SizedBox(
                              width: 50,
                              child: TextFormField(
                                  initialValue: '0',
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    if (value.length > 0) {
                                      if (double.tryParse(value) != null) {
                                        if (int.parse(value) > 0) {
                                          _selectedInventories[index].quantity =
                                              int.parse(value);

                                          print(_selectedInventories[index]
                                              .quantity);
                                        }
                                      }
                                    }
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (value) {
                                    if (double.tryParse(value!) == null) {
                                      return "Invalid";
                                    }
                                  })),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Column for selecting client and generating invoice button
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Button to generate invoice
              ElevatedButton(
                child: Container(
                  width: 170,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('Generate Invoice',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18)),
                ),
                onPressed: () {
                  if (_selectedInventories.isEmpty || _selectedClient == null) {
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text(
                            'Select Client and Inventories before generating Invoice.'),
                      ),
                    );
                  } else {
                    createAndSavePdf(_selectedInventories, _selectedClient!,
                        context: context);
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text("Invoice Generated Successfully."),
                            ));
                  }
                },
              ),
            ],
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
