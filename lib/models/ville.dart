import 'dart:math';

class Ville {
  String _name = 'Paris';
  double _id = 0.0;

  Ville(this._name) : this._id = Random().nextDouble();

  Ville.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this._id;
    data['name'] = this._name;

    return data;
  }

  //set get
  set name(String val) => _name = val;
  set id(double rnd) => _id = Random().nextDouble();

  String get name => _name;
  double get id => _id;
}
