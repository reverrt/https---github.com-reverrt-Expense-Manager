import 'package:expense/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'list_card.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  Function delete;
  TransactionList({@required this.transactions, @required this.delete});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: transactions.isEmpty
          ? Center(
              child: Text(
                "NO transactions",
                style: TextStyle(color: Colors.black45),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: transactions.length,
              itemBuilder: (context, idx) {
                return ListCard(
                  title: transactions[idx].nameTx,
                  date: DateFormat('d MMM, h:mm a')
                      .format(transactions[idx].dateTime),
                  price: transactions[idx].price,
                  deleteTx: delete,
                  id: transactions[idx].id,
                );
              }),
    );
  }
}
