import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: Covid(),
  ));
}

class Covid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID CHECK'),
        titleSpacing: 2.0,
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 5.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15.0),
            height: 120.0,
            color: Colors.red,
            decoration: BoxDecoration(),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 120.0,
            color: Colors.red,
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 120.0,
            color: Colors.red,
          ),
        ],
      )
    );
  }
}
