import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function add;
  NewTransaction({this.add});
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;
  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final title = titleController.text;
    final amount = int.parse(amountController.text);
    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.add(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Add new transaction",
                style: TextStyle(fontSize: 22, color: Colors.blueGrey),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(labelText: "title"),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Date"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _selectedDate == null
                              ? "Not chosen"
                              : DateFormat("d MMM").format(_selectedDate),
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.calendar_today_sharp,
                          color: Colors.green,
                        ),
                        onPressed: _presentDatePicker)
                  ]),
              Center(
                child: ElevatedButton(
                  onPressed: _submitData,
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
