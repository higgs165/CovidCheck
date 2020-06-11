import 'package:flutter/material.dart';
import 'api_call.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.white,
    ),
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
    super.initState();
    getStats();
  }

  bool isWaiting = false;
  Map<String, String> statsMap = {};

  void getStats() async {
    isWaiting = true;
    try {
      var data = await DataCall().getStats();
      isWaiting = false;
      setState(() {
        statsMap = data;
      });
    }
    catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('COVID-19 STATS'),
        centerTitle: true,
        elevation: 12.0,
        gradient: LinearGradient(
          colors: [Colors.lightBlue, Colors.blue.shade900],
        ),
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StatsCard(text: 'Confirmed', stat: isWaiting ? 'Retrieving... ' : statsMap['confirmed'], borderColour: Colors.orangeAccent, shadowColour: Colors.orangeAccent),
            StatsCard(text: 'Deaths', stat: isWaiting ? 'Retrieving... ' : statsMap['deaths'], borderColour: Colors.red.shade900, shadowColour: Colors.red),
            StatsCard(text: 'Recovered', stat: isWaiting ? 'Retrieving... ' : statsMap['recovered'], borderColour: Colors.lightGreenAccent, shadowColour: Colors.lightGreenAccent),
          ],
        ));
  }
}

class StatsCard extends StatelessWidget {
  StatsCard({this.text, this.stat, this.borderColour, this.shadowColour});

  final String text;
  final String stat;
  final Color borderColour;
  final Color shadowColour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [borderColour, Colors.white],
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Card(
          shadowColor: shadowColour,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 6.0,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              'Total $text = $stat',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
