//
import 'package:meteo_app/models/ville.dart';

class Meteo {
  Ville _city = Ville('Paris');
  //
  String _ville = "Paris";
  String _description = '';

  int _calendrier = 1569137935;

  double _temperature = 0.0;
  double _humidite = 0.0;
  double _pression = 0.0;
  double _vent = 0.0;
  double _ozone = 0.0;

  //set getter

  //String get ville => _ville;
  String get ville => _city.name;
  String get description => _description;

  int get calendrier => _calendrier;

  double get temperature => _temperature;
  double get humidite => _humidite;
  double get pression => _pression;
  double get vent => _vent;
  double get ozone => _ozone;

  //set ville(String city) => _ville = city;
  set ville(String city) => _city.name = city;
  set description(String value) => _description = value;

  set calendrier(int value) => _calendrier = value;

  set temperature(double val) => _temperature = val;
  set pression(double val) => _pression = val;
  set humidite(double val) => _humidite = val;
  set vent(double val) => _vent = val;
  set ozone(double val) => _ozone = val;

  String toString() {
    return '$_ville: temperature:$_temperature:description: $_description';
  }
}
