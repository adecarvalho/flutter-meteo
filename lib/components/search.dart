import 'package:flutter/material.dart';
import 'package:meteo_app/store/meteo_store.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  Search();

  @override
  _SearchState createState() => _SearchState();
}

//
class _SearchState extends State<Search> {
  //
  final _formKey = GlobalKey<FormState>();
  String _city = '';

  @override
  void initState() {
    _city = '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    final store = Provider.of<MeteoStore>(context, listen: false);

    //
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _formKey.currentState.reset();

      store.setVille(_city);
    }
  }

  String _validator(String input) {
    if (input.trim() == '')
      return 'Veuiller saisir une ville';
    else {
      return null;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Card(
        color: Colors.grey[200],
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                //
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(labelText: "Saisir une Ville"),
                    onSaved: (input) => _city = input,
                    validator: (val) => _validator(val),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                      child: RaisedButton(
                        onPressed: () {
                          print('action');
                          _submit();
                        },
                        color: Colors.purpleAccent,
                        child: Text("Valider",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
