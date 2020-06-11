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

  bool isWaiting = false;
  Map<String, String> statsMap = {};

  void getStats() async {
    isWaiting = true;

    try {
      var data = await DataCall().getStats();
      isWaiting = true;
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
            StatsCard(text: 'Confirmed', stat: statsMap['confirmed']),
            StatsCard(text: 'Deaths', stat: statsMap['deaths']),
            StatsCard(text: 'Recovered', stat: statsMap['recovered']),
          ],
        ));
  }
}

class StatsCard extends StatelessWidget {
  StatsCard({this.text, this.stat});

  final String text;
  final String stat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        margin: EdgeInsets.all(15.0),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 6.0,
        child: Text(
          'Total $text = $stat',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}
