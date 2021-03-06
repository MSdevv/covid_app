import 'dart:convert';
import 'package:covid_app/models/covid_info_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  final String _baseUrl = 'coronavirusapi-france.now.sh';

  Future<CovidInfo> fetchCovidInfoGlobal() async {
    final String _globalDataParameter = 'FranceLiveGlobalData';
    Uri uri = Uri.https(_baseUrl, _globalDataParameter);
    print('uri ***************** $uri');

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        print('response OK');

        Map<String, dynamic> responseJSON = json.decode(response.body);

        Map<String, dynamic> covidInfoMap =
            responseJSON['FranceGlobalLiveData'][0];

        print(covidInfoMap);
        CovidInfo covidInfo = CovidInfo.fromMap(covidInfoMap);

        print('covid.confirmed : ********${covidInfo.confirmed}');
        return covidInfo;
      }
    } catch (err) {
      print(err.toString());
      throw err.toString();
    }
  }

  Future<CovidInfo> fetchCovidInfoByDepartement(String departement) async {
    final String _departementParameter = 'LiveDataByDepartement';

    print('launching departement fetch');

    Map<String, String> parameters = {'Departement': departement};
    Uri uri = Uri.https(_baseUrl, _departementParameter, parameters);
    print('uri ***************** $uri');

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        print('response departement OK');

        Map<String, dynamic> responseJSON = json.decode(response.body);

        Map<String, dynamic> covidInfoMap =
            responseJSON['LiveDataByDepartement'][0];

        print(covidInfoMap);
        CovidInfo covidInfo = CovidInfo.fromMap(covidInfoMap);

        return covidInfo;
      }
    } catch (err) {
      throw err.toString();
    }
  }
}
