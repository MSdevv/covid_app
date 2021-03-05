import 'package:covid_app/models/covid_info_model.dart';
import 'package:flutter/material.dart';

class StatsGridRegional extends StatefulWidget {
  final CovidInfo covidInfo;

  StatsGridRegional({this.covidInfo});

  @override
  _StatsGridRegionalState createState() => _StatsGridRegionalState();
}

class _StatsGridRegionalState extends State<StatsGridRegional> {
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
                _buildStatCard('Hospitalisés',
                    widget.covidInfo.hospitalized.toString(), Colors.orange),
                _buildStatCard(
                    'Déces', widget.covidInfo.deaths.toString(), Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Réanimation',
                    widget.covidInfo.reanimation.toString(), Colors.purple),
                _buildStatCard(
                    'Guéris', widget.covidInfo.cured.toString(), Colors.green),
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
                _buildStatCard('Nouvelles hospitalisations',
                    widget.covidInfo.newHospitalized.toString(), Colors.orange),
                _buildStatCard(
                    'Nouvelles réanimations',
                    widget.covidInfo.newReanimation.toString(),
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
