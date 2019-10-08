import 'package:flutter/material.dart';

class RowData extends StatelessWidget {
  final String titre;
  final String valeur;

  RowData({this.titre, this.valeur});

  Widget _createIconByName(String name) {
    if (name == 'Humidite') {
      return Icon(
        Icons.opacity,
        size: 25,
      );
    } else if (name == 'Pression') {
      return Icon(
        Icons.network_check,
        size: 25,
      );
    } else if (name == 'Ozone') {
      return Icon(
        Icons.backup,
        size: 25,
      );
    } else {
      return Icon(
        Icons.assistant_photo,
        size: 25,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _createIconByName(this.titre),
          Text(
            '$titre',
            style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(valeur),
        ],
      ),
    );
  }
}
