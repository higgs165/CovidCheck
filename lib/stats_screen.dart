import 'package:flutter/material.dart';
import 'api_call.dart';
import 'stats_cards.dart';
import 'countries_list.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  String selectedLocation = 'Global';
  bool isWaiting = false;

  DropdownButton<String> countriesDropdown() {
    List<String> dropdownItems = [];
    for (String country in countriesList) {
      dropdownItems.add(country);
    }

    return DropdownButton<String>(
      value: selectedLocation,
      items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      focusColor: Colors.lightBlueAccent,
      isExpanded: true,
      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
      iconSize: 40.0,
      dropdownColor: Colors.white,
      elevation: 6,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontFamily: 'Comfortaa',
      ),
      onChanged: (String newValue) {
        setState(() {
          selectedLocation = newValue;
          getStats();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getStats();
  }

  Map<String, String> statsMap = {};

  void getStats() async {
    isWaiting = true;
    try {
      var data = await DataCall().getStats(selectedLocation);
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
        leading: Icon(
          FontAwesomeIcons.virus,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.infoCircle,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Developed by Mark Higgins',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Text(
                            'Data retrieved using the NovelCOVIDAPI',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ],
        title: Text('CovidCheck'),
        centerTitle: true,
        elevation: 12.0,
        gradient: LinearGradient(
          colors: [Colors.lightBlue, Colors.blue.shade900],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
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
              child: countriesDropdown(),
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
                  StatsContainer(
                      text: 'Confirmed',
                      stat: isWaiting ? 'Loading...' : statsMap['confirmed'],
                      statColour: Colors.orange,
                      icon: FontAwesomeIcons.checkSquare,
                      iconColour: Colors.orange),
                  StatsContainer(
                      text: 'Deaths',
                      stat: isWaiting ? 'Loading...' : statsMap['deaths'],
                      statColour: Colors.red,
                      icon: FontAwesomeIcons.skullCrossbones,
                      iconColour: Colors.red),
                  StatsContainer(
                      text: 'Recovered',
                      stat: isWaiting ? 'Loading...' : statsMap['recovered'],
                      statColour: Colors.green,
                      icon: FontAwesomeIcons.heartbeat,
                      iconColour: Colors.green),
                  StatsContainer(
                      text: 'Cases Today',
                      stat: isWaiting ? 'Loading...' : statsMap['casesToday'],
                      statColour: Colors.orange,
                      icon: FontAwesomeIcons.calendarDay,
                      icon2: FontAwesomeIcons.checkSquare,
                      iconColour: Colors.orange),
                  StatsContainer(
                      text: 'Deaths Today',
                      stat: isWaiting ? 'Loading...' : statsMap['deathsToday'],
                      statColour: Colors.red,
                      icon: FontAwesomeIcons.calendarDay,
                      icon2: FontAwesomeIcons.skullCrossbones,
                      iconColour: Colors.red),
                  SizedBox(height: 20.0),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Spinner extends StatelessWidget {
  const Spinner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitWave(
        color: Colors.white,
        size: 30.0,
      ),
    );
  }
}
