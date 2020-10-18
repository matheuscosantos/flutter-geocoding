import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MaterialApp(
  home: HomeScreen(),
));

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{

  String cidade = "";
  String estado = "";
  String pais = "";

  @override
  void initState(){
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(geoposition.latitude, geoposition.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    debugPrint('location: ${geoposition.latitude}');
    debugPrint('location: ${geoposition.longitude}');
    debugPrint('Cidade: ${first.subAdminArea}');
    debugPrint('Estado: ${first.adminArea}');
    debugPrint('País: ${first.countryName}');
    setState(() {
      cidade = first.subAdminArea;
      estado = first.adminArea;
      pais = first.countryName;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        ),
      body: Column(
        children: [
          Text(cidade),
          Text(estado),
          Text(pais),
        ],
      ),
    );
  }
}