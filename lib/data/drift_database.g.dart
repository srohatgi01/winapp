// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  Client(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber});
  factory Client.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Client(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      phoneNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['phone_number'] = Variable<String>(phoneNumber);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      phoneNumber: Value(phoneNumber),
    );
  }

  factory Client.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
    };
  }

  Client copyWith(
          {int? id, String? name, String? email, String? phoneNumber}) =>
      Client(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );
  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, phoneNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.phoneNumber == this.phoneNumber);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> phoneNumber;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String phoneNumber,
  })  : name = Value(name),
        email = Value(email),
        phoneNumber = Value(phoneNumber);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phoneNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
    });
  }

  ClientsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String>? phoneNumber}) {
    return ClientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 60),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 60),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String?> phoneNumber = GeneratedColumn<String?>(
      'phone_number', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, email, phoneNumber];
  @override
  String get aliasedName => _alias ?? 'clients';
  @override
  String get actualTableName => 'clients';
  @override
  VerificationContext validateIntegrity(Insertable<Client> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Client.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final int clientId;
  final String comments;
  final String totalPrice;
  Invoice(
      {required this.id,
      required this.clientId,
      required this.comments,
      required this.totalPrice});
  factory Invoice.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Invoice(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
      comments: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}comments'])!,
      totalPrice: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    map['comments'] = Variable<String>(comments);
    map['total_price'] = Variable<String>(totalPrice);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      clientId: Value(clientId),
      comments: Value(comments),
      totalPrice: Value(totalPrice),
    );
  }

  factory Invoice.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      comments: serializer.fromJson<String>(json['comments']),
      totalPrice: serializer.fromJson<String>(json['totalPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'comments': serializer.toJson<String>(comments),
      'totalPrice': serializer.toJson<String>(totalPrice),
    };
  }

  Invoice copyWith(
          {int? id, int? clientId, String? comments, String? totalPrice}) =>
      Invoice(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        comments: comments ?? this.comments,
        totalPrice: totalPrice ?? this.totalPrice,
      );
  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('comments: $comments, ')
          ..write('totalPrice: $totalPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientId, comments, totalPrice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.comments == this.comments &&
          other.totalPrice == this.totalPrice);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<String> comments;
  final Value<String> totalPrice;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.comments = const Value.absent(),
    this.totalPrice = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    required String comments,
    required String totalPrice,
  })  : clientId = Value(clientId),
        comments = Value(comments),
        totalPrice = Value(totalPrice);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<String>? comments,
    Expression<String>? totalPrice,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (comments != null) 'comments': comments,
      if (totalPrice != null) 'total_price': totalPrice,
    });
  }

  InvoicesCompanion copyWith(
      {Value<int>? id,
      Value<int>? clientId,
      Value<String>? comments,
      Value<String>? totalPrice}) {
    return InvoicesCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      comments: comments ?? this.comments,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (comments.present) {
      map['comments'] = Variable<String>(comments.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<String>(totalPrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('comments: $comments, ')
          ..write('totalPrice: $totalPrice')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _clientIdMeta = const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int?> clientId = GeneratedColumn<int?>(
      'client_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES clients(id)');
  final VerificationMeta _commentsMeta = const VerificationMeta('comments');
  @override
  late final GeneratedColumn<String?> comments = GeneratedColumn<String?>(
      'comments', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1, maxTextLength: 1000),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  @override
  late final GeneratedColumn<String?> totalPrice = GeneratedColumn<String?>(
      'total_price', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 7),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, clientId, comments, totalPrice];
  @override
  String get aliasedName => _alias ?? 'invoices';
  @override
  String get actualTableName => 'invoices';
  @override
  VerificationContext validateIntegrity(Insertable<Invoice> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('comments')) {
      context.handle(_commentsMeta,
          comments.isAcceptableOrUnknown(data['comments']!, _commentsMeta));
    } else if (isInserting) {
      context.missing(_commentsMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price']!, _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Invoice.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Inventorie extends DataClass implements Insertable<Inventorie> {
  final int id;
  final String itemName;
  final String itemPrice;
  final int? itemQuantity;
  Inventorie(
      {required this.id,
      required this.itemName,
      required this.itemPrice,
      this.itemQuantity});
  factory Inventorie.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Inventorie(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      itemName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_name'])!,
      itemPrice: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_price'])!,
      itemQuantity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_quantity']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_name'] = Variable<String>(itemName);
    map['item_price'] = Variable<String>(itemPrice);
    if (!nullToAbsent || itemQuantity != null) {
      map['item_quantity'] = Variable<int?>(itemQuantity);
    }
    return map;
  }

  InventoriesCompanion toCompanion(bool nullToAbsent) {
    return InventoriesCompanion(
      id: Value(id),
      itemName: Value(itemName),
      itemPrice: Value(itemPrice),
      itemQuantity: itemQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(itemQuantity),
    );
  }

  factory Inventorie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Inventorie(
      id: serializer.fromJson<int>(json['id']),
      itemName: serializer.fromJson<String>(json['itemName']),
      itemPrice: serializer.fromJson<String>(json['itemPrice']),
      itemQuantity: serializer.fromJson<int?>(json['itemQuantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemName': serializer.toJson<String>(itemName),
      'itemPrice': serializer.toJson<String>(itemPrice),
      'itemQuantity': serializer.toJson<int?>(itemQuantity),
    };
  }

  Inventorie copyWith(
          {int? id, String? itemName, String? itemPrice, int? itemQuantity}) =>
      Inventorie(
        id: id ?? this.id,
        itemName: itemName ?? this.itemName,
        itemPrice: itemPrice ?? this.itemPrice,
        itemQuantity: itemQuantity ?? this.itemQuantity,
      );
  @override
  String toString() {
    return (StringBuffer('Inventorie(')
          ..write('id: $id, ')
          ..write('itemName: $itemName, ')
          ..write('itemPrice: $itemPrice, ')
          ..write('itemQuantity: $itemQuantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemName, itemPrice, itemQuantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Inventorie &&
          other.id == this.id &&
          other.itemName == this.itemName &&
          other.itemPrice == this.itemPrice &&
          other.itemQuantity == this.itemQuantity);
}

class InventoriesCompanion extends UpdateCompanion<Inventorie> {
  final Value<int> id;
  final Value<String> itemName;
  final Value<String> itemPrice;
  final Value<int?> itemQuantity;
  const InventoriesCompanion({
    this.id = const Value.absent(),
    this.itemName = const Value.absent(),
    this.itemPrice = const Value.absent(),
    this.itemQuantity = const Value.absent(),
  });
  InventoriesCompanion.insert({
    this.id = const Value.absent(),
    required String itemName,
    required String itemPrice,
    this.itemQuantity = const Value.absent(),
  })  : itemName = Value(itemName),
        itemPrice = Value(itemPrice);
  static Insertable<Inventorie> custom({
    Expression<int>? id,
    Expression<String>? itemName,
    Expression<String>? itemPrice,
    Expression<int?>? itemQuantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemName != null) 'item_name': itemName,
      if (itemPrice != null) 'item_price': itemPrice,
      if (itemQuantity != null) 'item_quantity': itemQuantity,
    });
  }

  InventoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? itemName,
      Value<String>? itemPrice,
      Value<int?>? itemQuantity}) {
    return InventoriesCompanion(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      itemPrice: itemPrice ?? this.itemPrice,
      itemQuantity: itemQuantity ?? this.itemQuantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (itemPrice.present) {
      map['item_price'] = Variable<String>(itemPrice.value);
    }
    if (itemQuantity.present) {
      map['item_quantity'] = Variable<int?>(itemQuantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoriesCompanion(')
          ..write('id: $id, ')
          ..write('itemName: $itemName, ')
          ..write('itemPrice: $itemPrice, ')
          ..write('itemQuantity: $itemQuantity')
          ..write(')'))
        .toString();
  }
}

class $InventoriesTable extends Inventories
    with TableInfo<$InventoriesTable, Inventorie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoriesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _itemNameMeta = const VerificationMeta('itemName');
  @override
  late final GeneratedColumn<String?> itemName = GeneratedColumn<String?>(
      'item_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 130),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _itemPriceMeta = const VerificationMeta('itemPrice');
  @override
  late final GeneratedColumn<String?> itemPrice = GeneratedColumn<String?>(
      'item_price', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 7),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _itemQuantityMeta =
      const VerificationMeta('itemQuantity');
  @override
  late final GeneratedColumn<int?> itemQuantity = GeneratedColumn<int?>(
      'item_quantity', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, itemName, itemPrice, itemQuantity];
  @override
  String get aliasedName => _alias ?? 'inventories';
  @override
  String get actualTableName => 'inventories';
  @override
  VerificationContext validateIntegrity(Insertable<Inventorie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_name')) {
      context.handle(_itemNameMeta,
          itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta));
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('item_price')) {
      context.handle(_itemPriceMeta,
          itemPrice.isAcceptableOrUnknown(data['item_price']!, _itemPriceMeta));
    } else if (isInserting) {
      context.missing(_itemPriceMeta);
    }
    if (data.containsKey('item_quantity')) {
      context.handle(
          _itemQuantityMeta,
          itemQuantity.isAcceptableOrUnknown(
              data['item_quantity']!, _itemQuantityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Inventorie map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Inventorie.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $InventoriesTable createAlias(String alias) {
    return $InventoriesTable(attachedDatabase, alias);
  }
}

class InvoiceDetail extends DataClass implements Insertable<InvoiceDetail> {
  final int id;
  final int invoiceId;
  final int inventoryId;
  final int? itemQuantity;
  final int itemPrice;
  InvoiceDetail(
      {required this.id,
      required this.invoiceId,
      required this.inventoryId,
      this.itemQuantity,
      required this.itemPrice});
  factory InvoiceDetail.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return InvoiceDetail(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      invoiceId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}invoice_id'])!,
      inventoryId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}inventory_id'])!,
      itemQuantity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_quantity']),
      itemPrice: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_price'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['inventory_id'] = Variable<int>(inventoryId);
    if (!nullToAbsent || itemQuantity != null) {
      map['item_quantity'] = Variable<int?>(itemQuantity);
    }
    map['item_price'] = Variable<int>(itemPrice);
    return map;
  }

  InvoiceDetailsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceDetailsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      inventoryId: Value(inventoryId),
      itemQuantity: itemQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(itemQuantity),
      itemPrice: Value(itemPrice),
    );
  }

  factory InvoiceDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceDetail(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      inventoryId: serializer.fromJson<int>(json['inventoryId']),
      itemQuantity: serializer.fromJson<int?>(json['itemQuantity']),
      itemPrice: serializer.fromJson<int>(json['itemPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'inventoryId': serializer.toJson<int>(inventoryId),
      'itemQuantity': serializer.toJson<int?>(itemQuantity),
      'itemPrice': serializer.toJson<int>(itemPrice),
    };
  }

  InvoiceDetail copyWith(
          {int? id,
          int? invoiceId,
          int? inventoryId,
          int? itemQuantity,
          int? itemPrice}) =>
      InvoiceDetail(
        id: id ?? this.id,
        invoiceId: invoiceId ?? this.invoiceId,
        inventoryId: inventoryId ?? this.inventoryId,
        itemQuantity: itemQuantity ?? this.itemQuantity,
        itemPrice: itemPrice ?? this.itemPrice,
      );
  @override
  String toString() {
    return (StringBuffer('InvoiceDetail(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('inventoryId: $inventoryId, ')
          ..write('itemQuantity: $itemQuantity, ')
          ..write('itemPrice: $itemPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, invoiceId, inventoryId, itemQuantity, itemPrice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceDetail &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.inventoryId == this.inventoryId &&
          other.itemQuantity == this.itemQuantity &&
          other.itemPrice == this.itemPrice);
}

class InvoiceDetailsCompanion extends UpdateCompanion<InvoiceDetail> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> inventoryId;
  final Value<int?> itemQuantity;
  final Value<int> itemPrice;
  const InvoiceDetailsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.inventoryId = const Value.absent(),
    this.itemQuantity = const Value.absent(),
    this.itemPrice = const Value.absent(),
  });
  InvoiceDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required int inventoryId,
    this.itemQuantity = const Value.absent(),
    required int itemPrice,
  })  : invoiceId = Value(invoiceId),
        inventoryId = Value(inventoryId),
        itemPrice = Value(itemPrice);
  static Insertable<InvoiceDetail> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? inventoryId,
    Expression<int?>? itemQuantity,
    Expression<int>? itemPrice,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (inventoryId != null) 'inventory_id': inventoryId,
      if (itemQuantity != null) 'item_quantity': itemQuantity,
      if (itemPrice != null) 'item_price': itemPrice,
    });
  }

  InvoiceDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? invoiceId,
      Value<int>? inventoryId,
      Value<int?>? itemQuantity,
      Value<int>? itemPrice}) {
    return InvoiceDetailsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      inventoryId: inventoryId ?? this.inventoryId,
      itemQuantity: itemQuantity ?? this.itemQuantity,
      itemPrice: itemPrice ?? this.itemPrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (inventoryId.present) {
      map['inventory_id'] = Variable<int>(inventoryId.value);
    }
    if (itemQuantity.present) {
      map['item_quantity'] = Variable<int?>(itemQuantity.value);
    }
    if (itemPrice.present) {
      map['item_price'] = Variable<int>(itemPrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceDetailsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('inventoryId: $inventoryId, ')
          ..write('itemQuantity: $itemQuantity, ')
          ..write('itemPrice: $itemPrice')
          ..write(')'))
        .toString();
  }
}

class $InvoiceDetailsTable extends InvoiceDetails
    with TableInfo<$InvoiceDetailsTable, InvoiceDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceDetailsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _invoiceIdMeta = const VerificationMeta('invoiceId');
  @override
  late final GeneratedColumn<int?> invoiceId = GeneratedColumn<int?>(
      'invoice_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES invoices(id)');
  final VerificationMeta _inventoryIdMeta =
      const VerificationMeta('inventoryId');
  @override
  late final GeneratedColumn<int?> inventoryId = GeneratedColumn<int?>(
      'inventory_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES inventories(id)');
  final VerificationMeta _itemQuantityMeta =
      const VerificationMeta('itemQuantity');
  @override
  late final GeneratedColumn<int?> itemQuantity = GeneratedColumn<int?>(
      'item_quantity', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _itemPriceMeta = const VerificationMeta('itemPrice');
  @override
  late final GeneratedColumn<int?> itemPrice = GeneratedColumn<int?>(
      'item_price', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, invoiceId, inventoryId, itemQuantity, itemPrice];
  @override
  String get aliasedName => _alias ?? 'invoice_details';
  @override
  String get actualTableName => 'invoice_details';
  @override
  VerificationContext validateIntegrity(Insertable<InvoiceDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('inventory_id')) {
      context.handle(
          _inventoryIdMeta,
          inventoryId.isAcceptableOrUnknown(
              data['inventory_id']!, _inventoryIdMeta));
    } else if (isInserting) {
      context.missing(_inventoryIdMeta);
    }
    if (data.containsKey('item_quantity')) {
      context.handle(
          _itemQuantityMeta,
          itemQuantity.isAcceptableOrUnknown(
              data['item_quantity']!, _itemQuantityMeta));
    }
    if (data.containsKey('item_price')) {
      context.handle(_itemPriceMeta,
          itemPrice.isAcceptableOrUnknown(data['item_price']!, _itemPriceMeta));
    } else if (isInserting) {
      context.missing(_itemPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    return InvoiceDetail.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $InvoiceDetailsTable createAlias(String alias) {
    return $InvoiceDetailsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InventoriesTable inventories = $InventoriesTable(this);
  late final $InvoiceDetailsTable invoiceDetails = $InvoiceDetailsTable(this);
  late final ClientDao clientDao = ClientDao(this as MyDatabase);
  late final InvoiceDao invoiceDao = InvoiceDao(this as MyDatabase);
  late final InventoryDao inventoryDao = InventoryDao(this as MyDatabase);
  late final InvoiceDetailDao invoiceDetailDao =
      InvoiceDetailDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [clients, invoices, inventories, invoiceDetails];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ClientDaoMixin on DatabaseAccessor<MyDatabase> {
  $ClientsTable get clients => attachedDatabase.clients;
}
mixin _$InvoiceDaoMixin on DatabaseAccessor<MyDatabase> {
  $InvoicesTable get invoices => attachedDatabase.invoices;
}
mixin _$InventoryDaoMixin on DatabaseAccessor<MyDatabase> {
  $InventoriesTable get inventories => attachedDatabase.inventories;
}
mixin _$InvoiceDetailDaoMixin on DatabaseAccessor<MyDatabase> {}
