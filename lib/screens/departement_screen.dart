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

    print('dep************************** $depSplitted');

    print('hospi : ${covidInfobyDep.hospitalized}');
    print('gueri : ${covidInfobyDep.cured}');
    setState(() {
      _isLoading = false;
    });
    print('_isLoading fetchdata $_isLoading');
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

  // _buildStatGrid(CovidInfo covidInfo) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * 0.30,
  //     child: Column(
  //       children: <Widget>[
  //         Flexible(
  //           child: Row(
  //             children: <Widget>[
  //               _buildStatCard('Hospitalisés',
  //                   covidInfo.hospitalized.toString(), Colors.orange),
  //               _buildStatCard(
  //                   'Deces', covidInfo.deaths.toString(), Colors.red),
  //             ],
  //           ),
  //         ),
  //         Flexible(
  //           child: Row(
  //             children: <Widget>[
  //               _buildStatCard(
  //                   'Gueris', covidInfo.cured.toString(), Colors.green),
  //               _buildStatCard('Reanimation', covidInfo.reanimation.toString(),
  //                   Colors.purple),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _buildStatCard(String title, String count, MaterialColor color) {
  //   return Expanded(
  //     child: Container(
  //       margin: const EdgeInsets.all(8.0),
  //       padding: const EdgeInsets.all(10.0),
  //       decoration: BoxDecoration(
  //         color: color,
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Text(
  //             title,
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontSize: 15.0,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           Text(
  //             count,
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontSize: 20.0,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
