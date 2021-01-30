import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions,this.deleteTransaction);

  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                  height: 200,
                  margin: EdgeInsets.only(top: 10),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                // Using Card

                // return Card(
                //   child: Row(children: <Widget>[
                //     Container(
                //       child: Text(
                //         '\$${transactions[index].amount.toStringAsFixed(2)}',
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 20,
                //           color: Theme.of(context).primaryColor,
                //         ),
                //       ),
                //       margin: EdgeInsets.symmetric(
                //         vertical: 10,
                //         horizontal: 15,
                //       ),
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Theme.of(context).primaryColor,
                //           width: 2,
                //         ),
                //       ),
                //       padding: EdgeInsets.all(10),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         Text(
                //           transactions[index].title,
                //           style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         Text(
                //           DateFormat('dd MMMM, yyyy')
                //               .format(transactions[index].transactionDate),
                //           style: TextStyle(color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ]),
                // );

                // Using ListTile which is used for displaying elements in List

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(transactions[index].transactionDate),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor, onPressed: ()=>deleteTransaction(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
