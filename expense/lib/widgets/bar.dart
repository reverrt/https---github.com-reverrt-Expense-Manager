import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final String day;
  final double factor;
  Bar({@required this.day, @required this.factor});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          width: 16,
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              FractionallySizedBox(
                  heightFactor: factor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          day,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
