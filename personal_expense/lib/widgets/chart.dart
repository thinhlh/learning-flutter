import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        totalSum += (recentTransactions[i].transactionDate.day == weekDay.day &&
                recentTransactions[i].transactionDate.month == weekDay.month &&
                recentTransactions[i].transactionDate.year == weekDay.year)
            ? recentTransactions[i].amount
            : 0;
      } // if same day, add to the amount of existing day

      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(
        0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues
              .map(
                (data) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    data['day'],
                    data['amount'],
                    (data['amount'] as double) /
                        ((maxSpending == 0) ? 1 : maxSpending),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
