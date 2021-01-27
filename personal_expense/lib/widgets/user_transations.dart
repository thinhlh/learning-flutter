import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [];

  _UserTransactionsState()
  {
    for(int i=0;i<100000;i++)
      _userTransactions.add(Transaction(amount: 1,id: 1,title: '',transactionDate: DateTime.now()));
  }
  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(
        id: _userTransactions.length + 1,
        title: title,
        amount: amount,
        transactionDate: DateTime.now());
    setState(() {
      _userTransactions.insert(0, newTransaction);
    });
  }
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
