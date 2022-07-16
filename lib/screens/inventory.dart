import 'package:drift/drift.dart' as d;
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:winapp/widgets/bds-appbar.dart';

import '../data/drift_database.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  final TextEditingController _additemNameController = TextEditingController();
  final TextEditingController _additemPriceController = TextEditingController();
  final TextEditingController _additemQuantityController =
      TextEditingController();
  final TextEditingController _updateitemNameController =
      TextEditingController();
  final TextEditingController _updateitemPriceController =
      TextEditingController();
  final TextEditingController _updateitemQuantityController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late final database;
  late Stream<List> stream;

  @override
  void initState() {
    // TODO: implement initState
    database = Provider.of<MyDatabase>(context, listen: false);
    stream = database.inventoryDao.watchAllInventory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BdsAppBar(),
        body: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          stream = database.inventoryDao.watchSearchByItemName(
                              _searchController.value.text);
                        });
                      },
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'Search Inventory',
                        constraints: BoxConstraints(maxWidth: 600),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Search Button
                    // ElevatedButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       stream = database.inventoryDao.watchSearchByItemName(
                    //           _searchController.value.text);
                    //     });
                    //   },
                    //   child: Container(
                    //     // width: 270,
                    //     height: 50,
                    //     alignment: Alignment.center,
                    //     child: const Text(
                    //       "Search",
                    //       style: TextStyle(fontSize: 18),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                // Add new item button
                ElevatedButton(
                  onPressed: () => _addNewInventoryDialog(context, database),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Add New Item",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Inventory List Tile Heading
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  color: Colors.grey.shade200,
                  child: const ListTile(
                    leading: Text(
                      "ID",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    title: Text(
                      "PART NAME",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      "PART QUANTITY",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 48,
                  color: Colors.grey.shade200,
                )
              ],
            ),
            // Inventory List View builder
            StreamBuilder(
                stream: stream,
                initialData: [database.inventoryDao.watchAllInventory()],
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.hasData) {
                    // print(snapshot.data.toString());
                    List<Inventorie> inventory =
                        snapshot.data as List<Inventorie>;
                    // print(inventory);
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) => Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
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
                                trailing: Text(
                                  inventory[index].itemQuantity.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () => _updateInventoryDialog(
                                    context, database, inventory[index]),
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18,
                                ))
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
        ));
  }

  Future<dynamic> _addNewInventoryDialog(
      BuildContext context, MyDatabase database) {
    return showDialog(
        builder: (context) => Dialog(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 130),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Add Item to Inventory",
                          style: TextStyle(fontSize: 30)),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _additemNameController,
                        validator: _fieldsValidator,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Item Name',
                          constraints: BoxConstraints(maxWidth: 300),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _additemPriceController,
                            validator: _numberFieldsValidator,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Item Price',
                                constraints: BoxConstraints(maxWidth: 145)),
                          ),
                          const SizedBox(width: 10),
                          TextFormField(
                            controller: _additemQuantityController,
                            validator: _numberFieldsValidator,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Quantity',
                                constraints: BoxConstraints(maxWidth: 145)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        child: Container(
                          width: 270,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text('Add New Item',
                              style: TextStyle(fontSize: 18)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final inventory = InventoriesCompanion(
                                itemName:
                                    d.Value(_additemNameController.value.text),
                                itemPrice:
                                    d.Value(_additemPriceController.value.text),
                                itemQuantity: d.Value(int.parse(
                                    _additemQuantityController.value.text)));

                            database.inventoryDao
                                .insertInventory(inventory)
                                .then((value) => {
                                      _additemNameController.clear(),
                                      _additemPriceController.clear(),
                                      _additemQuantityController.clear(),
                                      Navigator.pop(context),
                                    });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
        context: context);
  }

  Future<dynamic> _updateInventoryDialog(
      BuildContext context, MyDatabase database, Inventorie inventorie) {
    // assigning values to the fields in update dialog
    _updateitemNameController.text = inventorie.itemName;
    _updateitemPriceController.text = inventorie.itemPrice;
    _updateitemQuantityController.text = inventorie.itemQuantity.toString();

    // Returning Dialog Box
    return showDialog(
        builder: (context) => Dialog(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 130),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Update Item", style: TextStyle(fontSize: 30)),
                      const SizedBox(height: 30),
                      TextFormField(
                        // initialValue: inventorie.itemName,
                        controller: _updateitemNameController,
                        validator: _fieldsValidator,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Item Name',
                          constraints: BoxConstraints(maxWidth: 300),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            // initialValue: inventorie.itemPrice,
                            controller: _updateitemPriceController,
                            validator: _numberFieldsValidator,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Item Price',
                                constraints: BoxConstraints(maxWidth: 145)),
                          ),
                          const SizedBox(width: 10),
                          TextFormField(
                            // initialValue: inventorie.itemQuantity.toString(),
                            controller: _updateitemQuantityController,
                            validator: _numberFieldsValidator,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Quantity',
                                constraints: BoxConstraints(maxWidth: 145)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        child: Container(
                          width: 270,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text('Update Item',
                              style: TextStyle(fontSize: 18)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            database.inventoryDao
                                .updateInventory(inventorie.copyWith(
                                    itemName:
                                        _updateitemNameController.value.text,
                                    itemPrice:
                                        _updateitemPriceController.value.text,
                                    itemQuantity: int.parse(
                                        _updateitemQuantityController
                                            .value.text)))
                                .then((value) => {
                                      _additemNameController.clear(),
                                      _additemPriceController.clear(),
                                      _additemQuantityController.clear(),
                                      Navigator.pop(context),
                                    });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
        context: context);
  }

  String? _fieldsValidator(String? value) {
    if (value!.isEmpty) return "Fields cannot be empty";
    return null;
  }

  String? _numberFieldsValidator(String? value) {
    if (value!.isEmpty)
      return "Fields cannot be empty";
    else if (double.tryParse(value) == null) return "Enter number";
    return null;
  }
}
