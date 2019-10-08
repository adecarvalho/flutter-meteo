import 'package:flutter/material.dart';
import 'package:meteo_app/models/ville.dart';
import 'package:meteo_app/store/favorite_store.dart';
import 'package:meteo_app/store/meteo_store.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
//
  ListView _buildList(context, listeVille) {
    return ListView.builder(
      itemCount: listeVille.length,
      //
      itemBuilder: (context, indice) => CardVille(ville: listeVille[indice]),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    final zeFavoriteStore = Provider.of<FavoriteStore>(context, listen: true);
    //
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text("Villes Favorites", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: Container(
        child: _buildList(context, zeFavoriteStore.listeVilles),
      ),
    );
  }
}

//
class CardVille extends StatefulWidget {
  final Ville ville;
  //
  const CardVille({Key key, this.ville}) : super(key: key);

  @override
  _CardVilleState createState() => _CardVilleState();
}

//
class _CardVilleState extends State<CardVille>
    with SingleTickerProviderStateMixin {
  //
  AnimationController _controller;
  Animation _animation;
//
  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    //_animation = Tween(begin: 1.0, end: 0.0).animate(_controller);
    _animation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    super.initState();
  }

  //
  void deleteHandler(FavoriteStore favorite) {
    _controller.forward().then((_) {
      _controller.reverse();
      favorite.deleteVille(this.widget.ville.id);
    });
  }

  //
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteStore>(context, listen: false);
    final meteo = Provider.of<MeteoStore>(context, listen: false);
    //
    return FadeTransition(
      opacity: _animation,
      child: Card(
        //
        child: ListTile(
          leading: Icon(Icons.room),
          onTap: () {
            //print("ouvrir: ${ville.id}");
            meteo.setVille(widget.ville.name);
            Navigator.pop(context);
          },
          trailing: IconButton(
            onPressed: () {
              deleteHandler(favorite);
              //favorite.deleteVille(this.widget.ville.id);
            },
            icon: Icon(
              Icons.delete,
            ),
          ),
          title: Text(
            '${widget.ville.name}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
