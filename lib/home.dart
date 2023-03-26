import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoHomePage extends StatefulWidget {
  const GeoHomePage({super.key});

  @override
  State<GeoHomePage> createState() => _GeoHomePageState();
}

class _GeoHomePageState extends State<GeoHomePage> {
  @override
  void initState() {
    super.initState();
    print("Starting . . .");
  }

  Position? _currentPosition;
  double? longitude, latitude;
  String? postalCode, city, country;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geo Live Locator"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_currentPosition != null)
                Container(
                  height: 220,
                  width: size.width * 0.8,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                  ),
                  child: Text(
                    "Longitude: $latitude \nLatitude: $latitude \n Postal COde: $postalCode \nCity: $city \nCountry: $country",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 2,
                    ),
                  ),
                ),
              TextButton(
                onPressed: () async {
                  print("Getting . . .");

                  await _getCurrentLocation();
                },
                child: Text(
                  _currentPosition != null
                      ? "Refresh Location"
                      : "Get Location",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    print("Getting >>>");

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print('Position determined: $position');
    _currentPosition = position;
    if (_currentPosition != null) {
      setState(() {
        longitude = _currentPosition!.longitude;
        latitude = _currentPosition!.latitude;
      });
      await _getAddressFromLatLng();
    } else {
      print("Error getting location");
    }
  }

  _getAddressFromLatLng() async {
    try {
      print("Trying ---");
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude!,
        longitude!,
      );

      Placemark place = placemarks[0];

      setState(() {
        postalCode = place.postalCode;
        city = place.locality;
        country = place.country;
      });
      print(
          "Longitude: $latitude \nLatitude: $latitude \n Postal COde: $postalCode \nCity: $city \nCountry: $country");
    } catch (e) {
      print(e);
    }
  }
}
