import 'package:flutter/material.dart';
import 'api_call.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: Covid(),
  ));
}

class Covid extends StatefulWidget {

  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStats();
  }

  var confirmed;
  var deaths;
  var recovered;

  void getStats() async {
    DataCall dataCall = DataCall();
    confirmed = await dataCall.getConfirmed();
    deaths = await dataCall.getDeaths();
    recovered = await dataCall.getRecovered();
  }

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15.0),
            height: 120.0,
            color: Colors.white,
            child: Center(
              child: Text(
                'Total Confirmed: $confirmed',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
            ),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 120.0,
            color: Colors.white,
            child: Center(
              child: Text(
                'Total Deaths: $deaths',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 120.0,
            color: Colors.white,
            child: Center(
              child: Text(
                'Total Recovered: $recovered',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
