import 'package:http/http.dart' as http;
import 'dart:convert';

const url = 'https://covid-api.com/api/reports/total';

class DataCall {

  Future getStats() async {

    Map<String, String> statMap = {};

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      int confirmed = data['data']['confirmed'];
      int deaths = data['data']['deaths'];
      int recovered = data['data']['recovered'];

      statMap['confirmed'] = confirmed.toString();
      statMap['deaths'] = deaths.toString();
      statMap['recovered'] = recovered.toString();
      return statMap;

    }
    else {
      print(response.statusCode);
      throw 'Get request could not be completed';
    }
  }
}