import 'package:intl/intl.dart';
import 'package:expense/model/bar_model.dart';
import 'package:expense/model/transaction_model.dart';
import 'package:expense/widgets/bar.dart';
import 'package:expense/widgets/new_transaction.dart';
import 'package:expense/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _userTransactions = [];

  List<BarModel> get barListValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0;
      for (var i = 0; i < _userTransactions.length; i++) {
        if (_userTransactions[i].dateTime.day == weekday.day &&
            _userTransactions[i].dateTime.month == weekday.month &&
            _userTransactions[i].dateTime.year == weekday.year) {
          totalSum += _userTransactions[i].price;
        }
      }
      return BarModel(day: weekday, sum: totalSum);
    }).toList();
  }

  int get totalSpending {
    return barListValues.fold(0, (tsum, item) {
      return tsum + item.sum;
    });
  }

  void addTx(String title, int amount, DateTime chosenDate) {
    final tx = Transaction(
        id: DateTime.now().toString(),
        nameTx: title,
        price: amount,
        dateTime: chosenDate);
    setState(() {
      _userTransactions.add(tx);
    });
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(add: addTx),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Expense"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                color: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: barListValues.length,
                    itemBuilder: (context, idx) {
                      return Bar(
                          day: DateFormat.E().format(barListValues[idx].day),
                          factor: totalSpending == 0
                              ? 0.0
                              : barListValues[idx].sum / totalSpending);
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Transactions",
                style: TextStyle(fontSize: 25, color: Colors.blueGrey),
              ),
              TransactionList(
                  transactions: _userTransactions, delete: _deleteTx),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddTransaction(context),
      ),
    );
  }
}
