import 'package:covid_app/data/data.dart';
import 'package:covid_app/models/covid_info_model.dart';
import 'package:covid_app/services/api_services.dart';
import 'package:covid_app/widgets/departement_dropdown.dart';
import 'package:covid_app/widgets/stats_grid_regional.dart';
import 'package:flutter/material.dart';

class DepartementScreen extends StatefulWidget {
  @override
  _DepartementScreenState createState() => _DepartementScreenState();
}

class _DepartementScreenState extends State<DepartementScreen> {
  CovidInfo covidInfobyDep;
  String _departement = '01-Ain';
  bool _isLoading = false;

  _fetchCovidInfo(String dep) async {
    String depSplitted =
        dep.contains('97') ? dep.substring(4) : dep.substring(3);
    covidInfobyDep =
        await APIService().fetchCovidInfoByDepartement(depSplitted);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _isLoading = false;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: DepartementDropdown(
                departements: departementsList,
                departement: _departement,
                onChanged: (val) async {
                  _departement = val;
                  setState(() {
                    _isLoading = true;
                  });
                  print('_isLoading on changed $_isLoading');
                  await _fetchCovidInfo(_departement);
                },
              ),
            ),
            SizedBox(height: 30),
            covidInfobyDep != null
                ? _isLoading
                    ? CircularProgressIndicator()
                    : StatsGridRegional(covidInfo: covidInfobyDep)
                : Text('Selectionner un departement'),
          ],
        ),
      ),
    );
  }
}
