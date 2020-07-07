import 'package:flutter/material.dart';

class StatsContainer extends StatelessWidget {

  StatsContainer({this.text, this.statColour, this.stat, this.icon, this.iconColour, this.icon2});

  final String text;
  final Color statColour;
  final String stat;
  final IconData icon;
  final IconData icon2;
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
          SizedBox(width: 5.0),
          Icon(
            icon2,
            color: iconColour,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              '$text',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 5.0),
          Text(
            '$stat',
            style: TextStyle(
              color: statColour,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}