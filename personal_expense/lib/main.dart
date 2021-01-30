import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './widgets/chart.dart';
import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent[100],
        fontFamily: GoogleFonts.roboto().fontFamily,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
      ),
      title: 'Personal Expenses',
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [];
  List<Transaction> get _recentTransactions {
    // Transactions in recent weeks
    return _userTransactions
        .where(
          (element) => element.transactionDate.isAfter(
            DateTime.now().subtract(Duration(days: 7)),
          ),
        )
        .toList();
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => NewTransaction(_addNewTransaction),
    );
  }

  void _addNewTransaction(
      String title, double amount, DateTime transactionDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        transactionDate: transactionDate);
    setState(
      () {
        _userTransactions.add(newTransaction);
        _userTransactions.sort(
          (a, b) => -a.transactionDate.compareTo(b.transactionDate),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() => _userTransactions.removeWhere((item) => item.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(_recentTransactions),
          Expanded(child: TransactionList(_userTransactions, _deleteTransaction)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
