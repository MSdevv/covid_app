class CovidInfo {
  final int confirmed;
  final int deaths;
  final int ehpadDeaths;
  final int hospitalized;
  final int reanimation;
  final int cured;
  final int newHospitalized;
  final int newReanimation;

  final String date;

  CovidInfo({
    this.confirmed,
    this.deaths,
    this.ehpadDeaths,
    this.hospitalized,
    this.reanimation,
    this.cured,
    this.date,
    this.newHospitalized,
    this.newReanimation,
  });

  factory CovidInfo.fromMap(Map<String, dynamic> map) {
    return CovidInfo(
      confirmed: map['casConfirmes'],
      deaths: map['deces'],
      cured: map['gueris'],
      ehpadDeaths: map['decesEhpad'],
      hospitalized: map['hospitalises'],
      reanimation: map['reanimation'],
      date: map['date'],
      newHospitalized: map['nouvellesHospitalisations'],
      newReanimation: map['nouvellesReanimations'],
    );
  }
}
