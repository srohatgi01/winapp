import 'package:drift/drift.dart' as d;
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:winapp/widgets/bds-appbar.dart';

import '../data/drift_database.dart';

class InventoryScreen extends StatelessWidget {
  InventoryScreen({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<InventoryDao>(context, listen: false);

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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search Inventory',
                        constraints: BoxConstraints(maxWidth: 600),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Container(
                        // width: 270,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          "Search",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    const inventory = InventoriesCompanion(
                        itemName: d.Value("Item Name"),
                        itemPrice: d.Value("1232"),
                        itemQuantity: d.Value(23));

                    database.insertInventory(inventory);
                  },
                  child: Container(
                    // width: 270,
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
            StreamBuilder(
                stream: database.watchAllInventory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.hasData) {
                    List<Inventorie> inventory =
                        snapshot.data as List<Inventorie>;
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
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                title: Text(
                                  inventory[index].itemName.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  "Rs " + inventory[index].itemPrice.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(
                                  inventory[index].itemQuantity.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
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
}
