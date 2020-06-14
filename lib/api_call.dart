import 'package:http/http.dart' as http;
import 'dart:convert';

class DataCall {
  Future getStats(String region) async {
    Map<String, String> statMap = {};
    String requestUrl = 'https://disease.sh/v2/countries/$region';

    http.Response response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      int confirmed = data['cases'];
      int deaths = data['deaths'];
      int recovered = data['recovered'];
      String flag = data['countryInfo']['flag'];

      statMap['confirmed'] = confirmed.toString();
      statMap['deaths'] = deaths.toString();
      statMap['recovered'] = recovered.toString();
      statMap['flag'] = flag.toString();

      print(statMap['flag']);

      return statMap;
    } else {
      print(response.statusCode);
      throw 'Get request failed';
    }
  }
}
