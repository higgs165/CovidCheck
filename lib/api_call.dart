import 'package:http/http.dart' as http;
import 'dart:convert';

class DataCall {
  Future getStats(String region) async {
    Map<String, String> statMap = {};
    String requestUrl;

    if(region == 'Global') {
      requestUrl = 'https://disease.sh/v2/all';
    }
    else {
      requestUrl = 'https://disease.sh/v2/countries/$region';
    }

    http.Response response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      int confirmed = data['cases'];
      int deaths = data['deaths'];
      int recovered = data['recovered'];
      int todayCases = data['todayCases'];
      int todayDeaths = data['todayDeaths'];

      statMap['confirmed'] = confirmed.toString();
      statMap['deaths'] = deaths.toString();
      statMap['recovered'] = recovered.toString();
      statMap['todayCases'] = todayCases.toString();
      statMap['todayDeaths'] = todayDeaths.toString();

      return statMap;
    } else {
      print(response.statusCode);
      throw 'Get request failed';
    }
  }
}
