import 'package:flutter/material.dart';
import 'package:meteo_app/components/row_datas.dart';
import 'package:meteo_app/store/meteo_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MeteoData extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    //
    return Consumer<MeteoStore>(builder: (context, storeLink, child) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey[300],
              width: 2,
            ),
          ),
          child: !storeLink.loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //
                    RowData(titre: 'Humidite', valeur: storeLink.getHumidite()),
                    //
                    RowData(titre: 'Pression', valeur: storeLink.getPression()),
                    //
                    RowData(titre: 'Vent', valeur: storeLink.getVent()),
                    //
                    RowData(titre: 'Ozone', valeur: storeLink.getOzone()),
                  ],
                )
              : Center(
                  child: SpinKitWave(
                    color: Colors.deepPurpleAccent,
                    size: 50.0,
                  ),
                ),
        ),
      );
    });
  }
}
