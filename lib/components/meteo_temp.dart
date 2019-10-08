import 'package:flutter/material.dart';
import 'package:meteo_app/store/meteo_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MeteoTemperature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final zeMeteoStore = Provider.of<MeteoStore>(
      context,
      listen: false,
    );
    //
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey[300],
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /////////////// ville ///////
            AfficheVille(zeMeteoStore: zeMeteoStore),
            ////////////////// temperature///////
            AfficheTemperature(zeMeteoStore: zeMeteoStore),
            ///////////////// description /////////////
            Affichedescription(zeMeteoStore: zeMeteoStore),
            ////////////////// calendrier ////////////////
            AfficheCalendrier(zeMeteoStore: zeMeteoStore),
          ],
        ),
      ),
    );
  }
}

//
class AfficheCalendrier extends StatelessWidget {
  const AfficheCalendrier({
    Key key,
    @required this.zeMeteoStore,
  }) : super(key: key);

  final MeteoStore zeMeteoStore;

  @override
  Widget build(BuildContext context) {
    return Text(zeMeteoStore.getTime());
  }
}

//
class AfficheVille extends StatelessWidget {
  const AfficheVille({
    Key key,
    @required this.zeMeteoStore,
  }) : super(key: key);

  final MeteoStore zeMeteoStore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          zeMeteoStore != null ? zeMeteoStore.getVille() : 'Ville',
          maxLines: 1,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        //
      ],
    );
  }
}

//
class Affichedescription extends StatelessWidget {
  const Affichedescription({
    Key key,
    @required this.zeMeteoStore,
  }) : super(key: key);

  final MeteoStore zeMeteoStore;

  @override
  Widget build(BuildContext context) {
    if (!zeMeteoStore.loading) {
      return Text(
        zeMeteoStore != null ? zeMeteoStore.getDescription() : '?',
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
      );
    } else {
      return Container();
    }
  }
}

//
class AfficheTemperature extends StatelessWidget {
  const AfficheTemperature({
    Key key,
    @required this.zeMeteoStore,
  }) : super(key: key);

  final MeteoStore zeMeteoStore;

  @override
  Widget build(BuildContext context) {
    if (zeMeteoStore.loading) {
      return Center(
        child: SpinKitWave(
          color: Colors.deepPurpleAccent,
          size: 50.0,
        ),
      );
    } else
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              zeMeteoStore != null ? zeMeteoStore.getTemperature() : '?',
              style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'C',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ],
      );
  }
}
