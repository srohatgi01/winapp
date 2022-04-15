import '../drift_database.dart';
import 'package:equatable/equatable.dart';

class InvoiceItems extends Equatable {
  final Inventorie inventorie;
  int? _quantity;
  double? _price;

  InvoiceItems({required this.inventorie});

  set quantity(int? value) {
    _quantity = value;
  }

  set price(double? value) {
    _price = value;
  }

  int? get quantity => _quantity;
  double? get price => _price;

  @override
  // TODO: implement props
  List<Object?> get props => [inventorie];
}
