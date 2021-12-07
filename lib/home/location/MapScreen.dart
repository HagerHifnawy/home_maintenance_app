import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_maintenance/home/location/LocationServices.dart';
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
  String name = '',
      phoneNumber = '',
      work = '';
  double? longitude, latitude;
  BitmapDescriptor? _locationIcon;
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(33.515343, 36.289590),
    zoom: 14.4746,
  );
  LatLng currentLocation = _initialCameraPosition.target;
  @override
  void initState() {
    super.initState();
    _buildMarkerFromAssets();
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
          title: TextFormField(
            onChanged: (newValue) {
              if (newValue == work) {
                setState(() {
                  _markers.add(Marker(
                      markerId: MarkerId('Id'),
                      position: LatLng(latitude!, longitude!)));
                });
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
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
                onTap: (latLing) {
                  setState(() {
                    _markers.add(
                        Marker(markerId: MarkerId('Id'), position: latLing));
                  });
                },
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) => _controller.complete(controller),
                onCameraMove: (e) => currentLocation = e.target,
                markers: _markers,
                polylines: _polylines),
            SizedBox(
              width: 40,
              height: 40,
              child:GestureDetector(
                child: Image.asset('assets/images/location_icon.png'),)
            )
          ],
        ));
  }

  void showDetails() {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Container(child:Column(
                mainAxisSize: MainAxisSize.min,
                children:[ Text(
              name,
              style: GoogleFonts.raleway(
                  fontSize: 15, color: MyThemeData.lightBlue),
            ),GestureDetector(
              onTap: getPhoneNumber,
                child: Icon(Icons.call,
              ),
            ),]),),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }

  void _setMarker(LatLng _location) {
    Marker newMarker = Marker(
      markerId: MarkerId(_location.toString()),
      onTap: showDetails,
      // icon: _locationIcon,
      position: _location,
      infoWindow: InfoWindow(
          title: "Title",
          snippet: "${currentLocation.latitude}, ${currentLocation.longitude}"),

    );
    _markers.add(newMarker);
    setState(() {});
  }

  Future<void> _buildMarkerFromAssets() async {
    if (_locationIcon == null) {
      _locationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(48, 48)),
          'assets/images/location_icon.png');
      setState(() {});
    }
  }

  Future<void> _getMyLocation() async {
    LocationData _myLocation = await LocationService().getLocation();
    _setMarker(LatLng(_myLocation.latitude!, _myLocation.longitude!));
    _animateCamera(LatLng(_myLocation.latitude!, _myLocation.longitude!));
  }

  Future<void> _animateCamera(LatLng _location) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _cameraPosition = CameraPosition(
      target: _location,
      zoom: 13.5,
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
      latitude = documentSnapshot['latitude'];
      longitude = documentSnapshot['longitude'];
      work = documentSnapshot['work'];
      name = documentSnapshot['name'];
      print(
          'latitude is :$latitude,longitude is : $longitude, work is : $work');
    });
   /* FirebaseFirestore.instance
        .collection('workers')
        .doc('JhgzxmodhGc3asRNZnVO')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      latitude = documentSnapshot['longitude'];
      longitude = documentSnapshot['latitude'];
      work = documentSnapshot['work'];
      name = documentSnapshot['name'];
      phoneNumber = documentSnapshot['phone number'];

      print(
          'latitude is :$latitude,longitude is : $longitude, work is : $work');
    });*/
  }
  Future<void> getPhoneNumber() async {
    FirebaseFirestore.instance
        .collection('workers')
        .doc('LmsUAVZFwVtW7NuD1fch')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        await FlutterPhoneDirectCaller.callNumber(
            documentSnapshot["phone number"]);
        print('Document data: ${documentSnapshot["phone number"]}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
