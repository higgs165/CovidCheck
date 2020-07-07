import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class DataCall {
  Future getStats(String region) async {
    Map<String, String> statMap = {};
    String requestUrl;

    //Adds commas to stats to make them more readable
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';

    if (region == 'Global') {
      requestUrl = 'https://disease.sh/v2/all';
    } else {
      requestUrl = 'https://disease.sh/v2/countries/$region';
    }

    http.Response response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      String confirmed = data['cases'].toString();
      String deaths = data['deaths'].toString();
      String recovered = data['recovered'].toString();
      String casesToday = data['todayCases'].toString();
      String deathsToday = data['todayDeaths'].toString();

      statMap['confirmed'] = confirmed.replaceAllMapped(reg, mathFunc);
      statMap['deaths'] = deaths.replaceAllMapped(reg, mathFunc);
      statMap['recovered'] = recovered.replaceAllMapped(reg, mathFunc);
      statMap['casesToday'] =
          casesToday.toString().replaceAllMapped(reg, mathFunc);
      statMap['deathsToday'] =
          deathsToday.toString().replaceAllMapped(reg, mathFunc);

      return statMap;
    } else {
      print(response.statusCode);
      throw 'GET request failed';
    }
  }
}
