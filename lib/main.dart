import 'package:flutter/material.dart';
import 'package:tp7/pages/Home.dart';
import 'package:tp7/pages/contact.dart';
import 'package:tp7/pages/evenement.dart';
import 'package:tp7/pages/mules.dart';
import 'package:tp7/pages/sanda.dart';
import 'package:tp7/pages/userdata.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home":(context){
          return HomePage();
        },

        "/register":(context) =>RegisterPage(),
        "/login":(context) =>LoginPage(),
        "/mules":(context) =>Mulesage(),
        "/sand":(context) => Sandpage(),
        "/home":(context) => HomePage(),

      },
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
     initialRoute: "/home",
    );
  }
}
