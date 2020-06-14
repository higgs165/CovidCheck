import 'package:flutter/material.dart';

class StatsContainer extends StatelessWidget {

  StatsContainer({this.text, this.statColour, this.stat});

  final String text;
  final Color statColour;
  final String stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54,
              offset: Offset(2.0, 2.0),
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Total $text',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
          Text(
            '$stat',
            style: TextStyle(
              color: statColour,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}