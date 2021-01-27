import 'package:flutter/foundation.dart';

class Transaction {
  final int id;
  final String title;
  final double amount;
  final DateTime transactionDate;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.transactionDate,
  });
}
