import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_database.g.dart';

class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  TextColumn get email => text().withLength(max: 60)();
  TextColumn get phoneNumber => text().withLength(max: 10)();
}

class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId =>
      integer().customConstraint('REFERENCES clients(id)')();
  TextColumn get comments => text().withLength(min: 1, max: 1000)();
  TextColumn get totalPrice => text().withLength(min: 1, max: 7)();
}

class Inventories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get itemName => text().withLength(min: 1, max: 130)();
  TextColumn get itemPrice => text().withLength(min: 1, max: 7)();
  IntColumn get itemQuantity => integer().nullable()();
}

class InvoiceDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId =>
      integer().customConstraint('REFERENCES invoices(id)')();
  IntColumn get inventoryId =>
      integer().customConstraint('REFERENCES inventories(id)')();
  IntColumn get itemQuantity => integer().nullable()();
  IntColumn get itemPrice => integer()();
}

@DriftDatabase(
    tables: [Clients, Invoices, Inventories, InvoiceDetails],
    daos: [ClientDao, InvoiceDao, InventoryDao, InvoiceDetailDao])
// _$AppDatabase is the name of the generated class
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

//Client Dao
@DriftAccessor(tables: [Clients])
class ClientDao extends DatabaseAccessor<MyDatabase> with _$ClientDaoMixin {
  final MyDatabase db;

  ClientDao(this.db) : super(db);

  Future<List<Client>> getAllClients() => select(clients).get();
  Stream<List<Client>> watchAllClients() => select(clients).watch();
  Future insertClient(Insertable<Client> client) =>
      into(clients).insert(client);
  Future updateClient(Insertable<Client> client) =>
      update(clients).replace(client);
}

// Invoices Dao
@DriftAccessor(tables: [Invoices])
class InvoiceDao extends DatabaseAccessor<MyDatabase> with _$InvoiceDaoMixin {
  final MyDatabase db;

  InvoiceDao(this.db) : super(db);

  Future<List<Invoice>> getAllInvoices() => select(invoices).get();
  // Stream<List<Client>> watchAllClients() => select(clients).watch();
  Future insertInvoice(Invoice invoice) => into(invoices).insert(invoice);
  // Future updateClient(Client client) => update(clients).replace(client);
}

// Inventory Dao
@DriftAccessor(tables: [Inventories])
class InventoryDao extends DatabaseAccessor<MyDatabase>
    with _$InventoryDaoMixin {
  final MyDatabase db;

  InventoryDao(this.db) : super(db);

  Future<List<Inventorie>> getAllInventory() => select(inventories).get();
  Stream<List<Inventorie>> watchAllInventory() => select(inventories).watch();
  Future insertInventory(Insertable<Inventorie> inventorie) =>
      into(inventories).insert(inventorie);
  Future updateInventory(Inventorie inventorie) =>
      update(inventories).replace(inventorie);
  Stream<List<Inventorie>> watchSearchByItemName(var searchWord) =>
      // (select(inventories)..where((tbl) => tbl.itemName.equals(searchWord)))
      (select(inventories)..where((tbl) => tbl.itemName.contains(searchWord)))
          .watch();
  // Stream<List<QueryRow>> watchSearchByItemName(String searchWord) =>
  //     customSelect("SELECT * FROM inventories WHERE item_name = '?'",
  //         variables: [Variable(searchWord)]).watch();
}

// InvoiceDetail Dao
@DriftAccessor(tables: [InvoiceDetail])
class InvoiceDetailDao extends DatabaseAccessor<MyDatabase>
    with _$InvoiceDetailDaoMixin {
  final MyDatabase db;

  InvoiceDetailDao(this.db) : super(db);

  // Future<List<InvoiceDetail>> getAllInvoiceDetails() =>
  //     select(invoiceDetails).get();
}
