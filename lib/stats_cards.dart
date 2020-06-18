import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatsContainer extends StatelessWidget {

  StatsContainer({this.text, this.statColour, this.stat, this.icon, this.iconColour});

  final String text;
  final Color statColour;
  final String stat;
  final IconData icon;
  final Color iconColour;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
          Icon(
            icon,
            color: iconColour,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              '$text',
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