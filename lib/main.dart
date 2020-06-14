import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api_call.dart';
import 'stats.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

bool isWaiting = false;

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.blue.shade700,
    ),
    home: Covid(),
  ));
}

class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  String country = 'Global';

  @override
  void initState() {
    super.initState();
    getStats();
  }

  Map<String, String> statsMap = {};

  void getStats() async {
    isWaiting = true;
    try {
      var data = await DataCall().getStats();
      isWaiting = false;
      setState(() {
        statsMap = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('COVID-19 Stats'),
        centerTitle: true,
        elevation: 12.0,
        gradient: LinearGradient(
          colors: [Colors.lightBlue, Colors.blue.shade900],
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30.0),
              padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: country,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  dropdownColor: Colors.white,
                  elevation: 6,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'Comfortaa',
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      country = newValue;
                    });
                  },
                  items: <String>['Global', 'Ireland', 'UK']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade900, Colors.purple],
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: ListView(
                children: <Widget>[
                  StatsContainer(text: 'Confirmed', stat: isWaiting ? 'Retrieving...' : statsMap['confirmed'], statColour: Colors.orangeAccent),
                  StatsContainer(text: 'Deaths', stat: isWaiting ? 'Retrieving...' : statsMap['deaths'], statColour: Colors.red),
                  StatsContainer(text: 'Recovered', stat: isWaiting ? 'Retrieving...' : statsMap['confirmed'], statColour: Colors.green),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


