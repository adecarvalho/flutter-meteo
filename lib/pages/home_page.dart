import 'package:flutter/material.dart';

import 'package:meteo_app/components/meteo_datas.dart';
import 'package:meteo_app/components/meteo_temp.dart';
import 'package:meteo_app/components/search.dart';
import 'package:meteo_app/store/favorite_store.dart';
import 'package:meteo_app/store/meteo_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  //

  void _showSnackBar(String txt) {
    final snackbar = SnackBar(
      content: Text(
        '$txt Ajoutée aux villes favorites',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      duration: Duration(milliseconds: 3500),
      action: SnackBarAction(
        label: "Editer",
        onPressed: () {
          Navigator.pushNamed(context, '/favorite');
        },
      ),
    );
    //show
    _scafoldKey.currentState.showSnackBar(snackbar);
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    final zeMeteoStore = Provider.of<MeteoStore>(
      context,
      listen: true,
    );

    //
    final zeFavoriteStore = Provider.of<FavoriteStore>(context, listen: false);

    //
    return Scaffold(
      key: _scafoldKey,
      backgroundColor: Colors.deepPurpleAccent,
      //
      floatingActionButton: FloatingActionButton(
        tooltip: 'Ajouter aux favories',
        onPressed: () {
          //new favorite
          final String txt = zeMeteoStore.getVille();

          zeFavoriteStore.addVille(txt);
          //
          _showSnackBar(txt);
          //Navigator.pushNamed(context, '/favorite');
        },
        child: Icon(Icons.favorite),
        backgroundColor: Colors.purpleAccent,
      ),
      appBar: AppBar(
        title: Text("Méteo App", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        actions: <Widget>[
          //
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/favorite');
            },
          ),
          //
          IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () {
              zeMeteoStore.getWeather();
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Search(),
                //
                MeteoTemperature(),
                //
                MeteoData(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
