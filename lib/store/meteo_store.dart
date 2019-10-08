import 'package:flutter/foundation.dart';
import 'package:meteo_app/models/meteo.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MeteoStore with ChangeNotifier {
  Meteo _meteo = Meteo();

  bool loading = false;

  //
  void setVille(String city) {
    this._meteo.ville = city;
    //print(this._meteo);
    getWeather();
    // notifyListeners();
  }

  //
  String getVille() {
    String txt =
        this._meteo.ville[0].toUpperCase() + this._meteo.ville.substring(1);
    return txt;
  }

  //
  String getTemperature() => this._meteo.temperature.toInt().toString();

  //
  String getDescription() => this._meteo.description;

  String getTime() {
    int cal = this._meteo.calendrier * 1000;
    DateTime jour = DateTime.fromMillisecondsSinceEpoch(cal);
    return 'le, ${DateFormat("dd-MM-yyyy").format(jour)}';
    //'${this._meteo.calendrier.toInt().toString()}';
  }

  //
  String getHumidite() => '${this._meteo.humidite.toInt().toString()} %';

  String getPression() => '${this._meteo.pression.toInt().toString()} hPa';

  String getVent() => '${this._meteo.vent.toInt().toString()} km/h';

  String getOzone() => '${this._meteo.ozone.toInt().toString()}';

  //
  void startLoading() {
    this.loading = true;
    notifyListeners();
  }

  //
  Future<Map> getLatLon() async {
    try {
      final String mville = this._meteo.ville;
      final url = 'https://darksky.net/geo?q=$mville';

      http.Response response = await http.get(url);
      Map data = jsonDecode(response.body);
      return data;
      //
    } catch (e) {
      print('Error' + e);
      return null;
    }
  }

  //
  Future<void> getWeatherDatas(String latitude, String longitude) async {
    try {
      final url =
          'https://api.darksky.net/forecast/47d989a018ba75eb1d2ee6793d8f7f9b/$latitude,$longitude/?lang=fr&units=ca';

      http.Response response = await http.get(url);
      Map data = jsonDecode(response.body)['currently'];

      //print(data);

      this._meteo.calendrier = data['time'];

      this._meteo.description = data['summary'];
      this._meteo.temperature = data['temperature'];
      this._meteo.humidite = data['humidity'] * 100;
      this._meteo.pression = data['pressure'];
      this._meteo.vent = data['windSpeed'];
      this._meteo.ozone = data['ozone'];
    } catch (e) {
      loading = false;
      print(e);
    }
  }

  //
  Future<void> getWeather() async {
    try {
      startLoading();

      Map latlon = await getLatLon();
      // print(latlon['latitude'].toString());
      // print(latlon['longitude'].toString());

      String latitude = latlon['latitude'].toString();
      String longitude = latlon['longitude'].toString();
      //print(latitude);
      //print(longitude);
      //
      await getWeatherDatas(latitude, longitude);
      notifyListeners();
      this.loading = false;
      //

    } catch (e) {
      print('Error get Weather' + e);
      this.loading = false;
    }
  }
}
