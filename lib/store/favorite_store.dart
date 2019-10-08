import 'package:flutter/material.dart';
import 'package:meteo_app/models/ville.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FavoriteStore with ChangeNotifier {
  final String saveMeteo = 'save_meteo';

  List<Ville> _villes = List<Ville>();

  FavoriteStore() {
    //print('start');
    //_villes.add(Ville('Paris'));
    //_villes.add(Ville('Cergy'));
    //_villes.add(Ville('Bezons'));

    // _villes.sort((a, b) => a.name.compareTo(b.name));
    init();
  }

  Future<void> init() async {
    await loadLocalStorage();
  }

  //set get
  List<Ville> get listeVilles => _villes;

  //
  Future<void> saveLocalStorage() async {
    //_villes = List<Ville>();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> mesVillesToSave = List<String>();
    //
    for (var item in _villes) {
      String encoded = jsonEncode(item);
      mesVillesToSave.add(encoded);
      //print(encoded);
    }

    prefs.setStringList(saveMeteo, mesVillesToSave);
  }

  //
  Future<void> loadLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> tmp = prefs.getStringList(saveMeteo);

    //print(tmp);
    //
    if (tmp.length > 0) {
      for (var item in tmp) {
        Map<String, dynamic> decode = jsonDecode(item);
        //print(decode);
        _villes.add(Ville(decode['name']));
      }
    }
    //
    //print(_villes);
  }

//
  bool isUnique(String txt) {
    for (var item in _villes) {
      if (item.name == txt) {
        return false;
      }
    }
    return true;
  }

//
  void deleteVille(double zeid) async {
    _villes = _villes.where((item) {
      return item.id != zeid;
    }).toList();

    notifyListeners();
    await saveLocalStorage();
  }

//
  void addVille(String name) async {
    //
    if (isUnique(name)) {
      _villes.add(Ville(name));
      _villes.sort((a, b) => a.name.compareTo(b.name));

      notifyListeners();
      await saveLocalStorage();
    }
  }
}
