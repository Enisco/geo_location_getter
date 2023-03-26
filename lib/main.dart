import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_getter/home.dart';

Future<void> main() async {   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const GeoHomePage(),
    );
  }
}
