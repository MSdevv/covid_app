import 'package:covid_app/models/covid_info_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsGridNational extends StatefulWidget {
  final CovidInfo covidInfo;

  StatsGridNational({this.covidInfo});

  @override
  _StatsGridNationalState createState() => _StatsGridNationalState();
}

class _StatsGridNationalState extends State<StatsGridNational> {
  var formatter = NumberFormat('##,000');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Données depuis le début de l\'épidémie',
              style: TextStyle(
                color: Colors.amber[100],
                fontSize: 15,
              ),
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                    'Cas confirmés',
                    formatter.format(widget.covidInfo.confirmed),
                    Colors.orange),
                _buildStatCard('Déces',
                    formatter.format(widget.covidInfo.deaths), Colors.red),
                _buildStatCard(
                    'Déces Ehpad',
                    formatter.format(widget.covidInfo.ehpadDeaths),
                    Colors.deepOrange),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                    'Hospitalisés',
                    formatter.format(widget.covidInfo.hospitalized),
                    Colors.pink),
                _buildStatCard(
                    'Réanimation',
                    formatter.format(widget.covidInfo.reanimation),
                    Colors.purple),
                _buildStatCard('Guéris',
                    formatter.format(widget.covidInfo.cured), Colors.green),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Nouvelles données depuis hier',
              style: TextStyle(
                color: Colors.amber[100],
                fontSize: 15,
              ),
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                    'Nouvelles hospitalisations',
                    formatter.format(widget.covidInfo.newHospitalized),
                    Colors.orange),
                _buildStatCard(
                    'Nouvelles réanimations',
                    formatter.format(widget.covidInfo.newReanimation),
                    Colors.lightBlue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
