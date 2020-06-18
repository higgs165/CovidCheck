import 'package:http/http.dart' as http;
import 'dart:convert';

class DataCall {
  Future getStats(String region) async {
    Map<String, String> statMap = {};
    String requestUrl;

    if (region == 'Global') {
      //requestUrl = 'https://disease.sh/v2/all';
      requestUrl = 'https://api.covidnow.com/v1/global/stats';
    } else {
      //requestUrl = 'https://disease.sh/v2/countries/$region';
      requestUrl = 'https://api.covidnow.com/v1/global/countries';
    }

    http.Response response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      int confirmed = data['data'][region]['nationwide']['confirmed'];
      int deaths = data['data'][region]['nationwide']['deaths'];
      int recovered = data['data'][region]['nationwide']['recovered'];

      statMap['confirmed'] = confirmed.toString();
      statMap['deaths'] = deaths.toString();
      statMap['recovered'] = recovered.toString();
//      statMap['todayCases'] = todayCases.toString();
//      statMap['todayDeaths'] = todayDeaths.toString();

      return statMap;
    } else {
      print(response.statusCode);
      throw 'Get request failed';
    }
  }
}
