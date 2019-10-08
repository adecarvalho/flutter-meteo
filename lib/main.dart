import 'package:flutter/material.dart';
import 'package:meteo_app/pages/favorite_page.dart';
import 'package:meteo_app/pages/home_page.dart';
import 'package:meteo_app/store/favorite_store.dart';
import 'package:meteo_app/store/meteo_store.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
//ChangeNotifierProvider(builder: (context) => MeteoStore(), child: MyApp()));

/* void main() => MultiProvider(
      providers: [
        //
        ChangeNotifierProvider(
          builder: (context) => MeteoStore(),
        ),
        //
      ],
      child: MyApp(),
    );
 */
//
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => MeteoStore(),
        ),
        //
        ChangeNotifierProvider(
          builder: (context) => FavoriteStore(),
        ),
      ],
      child: MaterialApp(
        title: 'Meteo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          secondaryHeaderColor: Colors.purpleAccent,
        ),
        //home: HomePage(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/favorite': (context) => Favorite(),
        },
      ),
    );
  }
}
