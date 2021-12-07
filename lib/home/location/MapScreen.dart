import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_maintenance/home/location/LocationServices.dart';
import 'package:home_maintenance/home/location/PolyServices.dart';
import 'package:home_maintenance/main.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = 'map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  String name = '', phoneNumber = '', work = '', slongitude = '', slatitude = '';
  double? longitude,latitude;
  //BitmapDescriptor? _locationIcon;
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(33.515343, 36.289590),
    zoom: 14.4746,
  );
  LatLng currentLocation = _initialCameraPosition.target;
  @override
  void initState() {
    super.initState();
    // _buildMarkerFromAssets();
    _getMyLocation();
    getWorkerData();

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
          title: Row(children: [TextFormField(
            onChanged: (newValue){
              if(newValue==work){
                longitude = double.parse(slongitude);
                assert(longitude is double);
                print(longitude);
                latitude = double.parse(slatitude);
                assert(latitude is double);
                print(latitude);
                _drawPolyline(
                    LatLng(longitude!, latitude!), currentLocation);
              }
            },
            autocorrect: true,
            decoration: InputDecoration(
              hintText: 'Search About Worker Near you Here...',
              hintStyle: TextStyle(color: MyThemeData.lightBlue),
              filled: true,
              fillColor: MyThemeData.backgroundColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.0)),
                borderSide: BorderSide(color: MyThemeData.lightBlue, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide(color: MyThemeData.lightBlue),
              ),
            ),
          ),
          Spacer(),
         /* GestureDetector(
            child: TextButton.icon(onPressed: , icon: icon, label: label),
          )*/
          ],)
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              onTap: (latLing) {
                setState(() {
                  _markers
                      .add(Marker(markerId: MarkerId('Id'), position: latLing));
                });
              },
              mapType: MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _controller.complete(controller),
              onCameraMove: (e) => currentLocation = e.target,
              markers: _markers,
              polylines: _polylines,
            ),
            /* SizedBox(
          width: 40,
          height: 40,
          child: Image.asset('assets/images/location_icon.png'),
        )*/
          ],
        ));
  }
  Future<void> _drawPolyline(LatLng from, LatLng to) async {
    Polyline polyline = await PolylineService().drawPolyline(from, to);

    _polylines.add(polyline);

    _setMarker(from);
    _setMarker(to);

    setState(() {});
  }

  void _setMarker(LatLng _location) {
    Marker newMarker = Marker(
      markerId: MarkerId(_location.toString()),
      // icon: _locationIcon,
      position: _location,
      infoWindow: InfoWindow(
          title: "Title",
          snippet: "${currentLocation.latitude}, ${currentLocation.longitude}"),
    );
    _markers.add(newMarker);
    setState(() {});
  }

  /*Future<void> _buildMarkerFromAssets() async {
    if (_locationIcon == null) {
      _locationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(48, 48)),
          'assets/images/location_icon.png');
      setState(() {});
    }
  }*/
  Future<void> _getMyLocation() async {
    LocationData _myLocation = await LocationService().getLocation();
    _setMarker(LatLng(_myLocation.latitude!, _myLocation.longitude!));
    _animateCamera(LatLng(_myLocation.latitude!, _myLocation.longitude!));
  }

  Future<void> _animateCamera(LatLng _location) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _cameraPosition = CameraPosition(
      target: _location,
      zoom: 16,
    );
    print(
        "animating camera to (lat: ${_location.latitude}, long: ${_location.longitude}");
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  getWorkerData() async {
    FirebaseFirestore.instance
        .collection('workers')
        .doc('LmsUAVZFwVtW7NuD1fch')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      slatitude  = documentSnapshot['longitude'];
      slongitude = documentSnapshot['latitude'];
      work = documentSnapshot['work'];
      print('latitude is :$slatitude,longitude is : $slongitude');
    });
  }
}
