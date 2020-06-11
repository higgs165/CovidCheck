import 'package:http/http.dart' as http;
import 'dart:convert';

const url = 'https://covid-api.com/api/reports/total';

class DataCall {

  Future getDeaths() async {

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      int deaths = data['data']['deaths'];
      return deaths;
    }
    else {
      print(response.statusCode);
    }
  }

  Future getConfirmed() async {

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      int recovered = data['data']['confirmed'];
      return recovered;
    }
    else {
      print(response.statusCode);
    }
  }

  Future getRecovered() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      int recovered = data['data']['recovered'];
      return recovered;
    }
    else {
      print(response.statusCode);
    }
  }
}