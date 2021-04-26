import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String title, date, id;
  final int price;
  final Function deleteTx;

  ListCard(
      {@required this.title,
      @required this.date,
      @required this.price,
      @required this.id,
      @required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(),
        height: 60,
        width: double.infinity,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 90,
                alignment: Alignment.center,
                color: Colors.green,
                child: Text(
                  "${price} RS",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(date)
                ],
              ),
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                deleteTx(id);
              })
        ]),
      ),
    );
  }
}
