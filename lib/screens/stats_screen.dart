import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:covid_app/config/palette.dart';
import 'package:covid_app/config/styles.dart';
import 'package:covid_app/data/data.dart';
import 'package:covid_app/models/covid_info_model.dart';
import 'package:covid_app/services/api_services.dart';
import 'package:covid_app/widgets/departement_dropdown.dart';
import 'package:covid_app/widgets/stats_grid_regional.dart';
import 'package:covid_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:graphic/graphic.dart' as graphic;

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  CovidInfo covidInfoNational;
  CovidInfo covidInfobyDep;
  String _departement = '01-Ain';

  bool _isLoading = false;
  int _currentIndex = 0;

  var _formatter = DateFormat('dd-MM-yyyy');
  DateTime _date;
  String _dateFormatted;

  @override
  void initState() {
    super.initState();
    _fetchCovidInfo();
  }

  _fetchCovidInfo() async {
    covidInfoNational = await APIService().fetchCovidInfoGlobal();
    _date = DateTime.parse(covidInfoNational.date);
    _dateFormatted = _formatter.format(_date);
    setState(() {
      _isLoading = false;
    });
  }

  _fetchCovidInfoDep(String dep) async {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.primaryColor,
        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _buildHeader(),
            _buildRegionTabBar(),
            _currentIndex == 0
                ? SliverPadding(
                    padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
                    sliver: SliverToBoxAdapter(
                      child: covidInfoNational != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 10),
                                  child: Text(
                                    'Données du : $_dateFormatted',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                StatsGridNational(
                                  covidInfo: covidInfoNational,
                                ),
                              ],
                            )
                          : Center(
                              child: Column(children: <Widget>[
                              CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                semanticsLabel: 'Patience',
                              ),
                              Text(
                                'Chargement...',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ])),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
                    sliver: SliverToBoxAdapter(
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
                                await _fetchCovidInfoDep(_departement);
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                          covidInfobyDep != null
                              ? _isLoading
                                  ? Column(children: <Widget>[
                                      CircularProgressIndicator(
                                          backgroundColor: Colors.white),
                                      Text(
                                        'Chargement...',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    ])
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, bottom: 10),
                                          child: Text(
                                            'Données du : $_dateFormatted',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                        StatsGridRegional(
                                          covidInfo: covidInfobyDep,
                                        ),
                                      ],
                                    )
                              : Text(
                                  'Selectionnez un departement',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(30, 30, 0, 20),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Statistiques',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            labelPadding: const EdgeInsets.all(8.0),
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text('National'),
              Text('Régional'),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
