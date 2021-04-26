import 'package:flutter/cupertino.dart';

class Transaction {
  final String id;
  final String nameTx;
  final int price;
  final DateTime dateTime;

  Transaction({
    @required this.id,
    @required this.nameTx,
    @required this.price,
    @required this.dateTime,
  });
}
