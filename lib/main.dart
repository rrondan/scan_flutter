import 'package:flutter/material.dart';
import 'package:sqcanner_qr_flutter/src/pages/home_page.dart';
import 'package:sqcanner_qr_flutter/src/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => HomePage(),
        "mapa": (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.teal
      ),
    );
  }
}
