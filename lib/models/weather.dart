import 'dart:convert';
import 'package:http/http.dart' as http;

//
class Weather {
  String city;
  String description = '';
  String temperature = '0';
  String humidity = '0';
  String pression = '0';
  String speed = '0';

  //
  Weather({this.city = 'Paris'});

  //
  Future<Map> getLatLon() async {
    try {
      final url = 'https://darksky.net/geo?q=${this.city}';

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

      this.description = data['summary'];
      this.temperature = data['temperature'].toString();
      this.humidity = data['humidity'].toString();
      this.pression = data['pressure'].toString();
      this.speed = data['windSpeed'].toString();
    } catch (e) {
      print(e);
    }
  }

  //
  Future<void> getWeather() async {
    try {
      Map latlon = await getLatLon();
      // print(latlon['latitude'].toString());
      // print(latlon['longitude'].toString());

      String latitude = latlon['latitude'].toString();
      String longitude = latlon['longitude'].toString();
      //print(latitude);
      //print(longitude);
      //
      await getWeatherDatas(latitude, longitude);
      //

    } catch (e) {
      print('Error get Weather' + e);
    }
  }
  //
}

/*
 * const latParis = 48.51;
const lonParis = 2.21;

async function getLatLon(city) {
  const url = `https://darksky.net/geo?q=${city}`;
  //
  try {
    const val = await fetch(url);
    return await val.json();
    //
  } catch (error) {
    console.log(error);
  }
}

async function getWeatherDatas(lat, lon) {
  try {
    const url = `https://api.darksky.net/forecast/47d989a018ba75eb1d2ee6793d8f7f9b/${lat},${lon}/?lang=fr&units=ca`;

    const val = await fetch(url);
    return await val.json();
    //
  } catch (error) {
    console.log(error);
  }
}

export async function getWeather(cityName) {
  //
  try {
    const {longitude, latitude} = await getLatLon(cityName);

    const meteo = await getWeatherDatas(longitude, latitude);

    return meteo.currently;
  } catch (error) {
    throw new Error('Errors get datas ...');
  }
}
 */
