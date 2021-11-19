import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_maintenance/main.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = 'map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];
   Position ?position;
  @override
  void initState()  {
    super.initState();
      _determinePosition().then((position) async{
       this.position=await position;
      setState(() {
        markers.add(Marker(
            markerId: MarkerId('myposition'),
            position: LatLng(position.latitude, position.longitude)));
      });
    }) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(200),
                bottomLeft: Radius.circular(200))),
        backgroundColor: MyThemeData.lightBlue,
      ),
      body: GoogleMap(
        onTap: (latLing) {
          setState(() {
            markers.add(Marker(markerId: MarkerId('Id'), position: latLing));
          });
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(position!.latitude,position!.longitude), zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers.toSet(),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
