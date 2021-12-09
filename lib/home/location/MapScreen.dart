import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
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
      work = '',
      name1 = '',
      phoneNumber1 = '',
      work1 = '',
      name2 = '',
      phoneNumber2 = '',
      work2 = '';
  double? longitude, latitude,  longitude1, latitude1,longitude2, latitude2
  ,distance,distance1,distance2;
  BitmapDescriptor? _locationIcon;
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(33.515343, 36.289590),
    zoom: 14.4746,
  );
  LatLng currentLocation = _initialCameraPosition.target;
  @override
  void initState() {
    super.initState();
    getWorkerData();
    _buildMarkerFromAssets();
    _getMyLocation();
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
            onTap: calculateDistance,
            onChanged: (newValue) {
              if(newValue==work&&distance!<=1600.000){
                setState(() {
                  _markers.add(Marker(
                      markerId: MarkerId('Id'),
                      infoWindow: InfoWindow(
                          onTap: showDetails,
                          title: "Click for more details",
                          snippet: "${latitude}, ${longitude}"),
                      position: LatLng(latitude!, longitude!)));
                });

              }
              if (newValue == work&& distance1!<=1600.000) {
              setState(() {
                _markers.add(Marker(
                    markerId: MarkerId('Id1'),
                    infoWindow: InfoWindow(
                        onTap: showDetails1,
                        title: "Click for more details",
                        snippet: "${latitude1}, ${longitude1}"),
                    position: LatLng(latitude1!, longitude1!)));
              });
              }
              if(newValue==work&&distance2!<=1600.000){
                setState(() {
                  _markers.add(Marker(
                      markerId: MarkerId('Id2'),
                      infoWindow: InfoWindow(
                          onTap: showDetails2,
                          title: "Click for more details",
                          snippet: "${latitude2}, ${longitude2}"),
                      position: LatLng(latitude2!, longitude2!)));
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

   showDetails() {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content:  Container(
              child:Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage:AssetImage('assets/images/carpenter.png'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          work,
                          style: GoogleFonts.raleway(
                              fontSize: 15, color: MyThemeData.lightBlue),),
                      ],
                    ),
                    Spacer(),
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                          Text(
                            name,
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          GestureDetector(
                            onTap: getPhoneNumber,
                            child: Icon(Icons.call,color: MyThemeData.lightBlue,
                            ),
                          ),]),]),),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: GoogleFonts.raleway(
                      fontSize: 15, color: MyThemeData.lightBlue),))
            ],
          );
        });
  }
  showDetails1() {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content:  Container(
              child:Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage:AssetImage('assets/images/carpenter.png'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          work1,
                          style: GoogleFonts.raleway(
                              fontSize: 15, color: MyThemeData.lightBlue),),
                      ],
                    ),
                    Spacer(),
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                          Text(
                            name1,
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          GestureDetector(
                            onTap: getPhoneNumber1,
                            child: Icon(Icons.call,color: MyThemeData.lightBlue,
                            ),
                          ),]),]),),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: GoogleFonts.raleway(
                      fontSize: 15, color: MyThemeData.lightBlue),))
            ],
          );
        });
  }
  showDetails2() {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Container(
              child:Row(
              children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            CircleAvatar(
            radius: 40.0,
              backgroundImage:AssetImage('assets/images/carpenter.png'),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                work2,
                style: GoogleFonts.raleway(
                    fontSize: 15, color: MyThemeData.lightBlue),),
              ],
            ),
            Spacer(),
            Column(
                mainAxisSize: MainAxisSize.min,
                children:[
                Text(
                  name2,
                  style: GoogleFonts.raleway(
                      fontSize: 15, color: MyThemeData.lightBlue),
                ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  GestureDetector(
                  onTap: getPhoneNumber2,
                  child: Icon(Icons.call,color: MyThemeData.lightBlue,
                  ),
                ),]),]),),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: GoogleFonts.raleway(
                      fontSize: 15, color: MyThemeData.lightBlue),))
            ],
          );
        });
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
    FirebaseFirestore.instance
        .collection('workers')
        .doc('JhgzxmodhGc3asRNZnVO')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      latitude1 = documentSnapshot['latitude'];
      longitude1 = documentSnapshot['longitude'];
      work1 = documentSnapshot['work'];
      name1 = documentSnapshot['name'];
      phoneNumber1 = documentSnapshot['phone number'];

      print(
          'latitude is :$latitude1,longitude is : $longitude1, work is : $work');
    });
    FirebaseFirestore.instance
        .collection('workers')
        .doc('WtjVrBmgtkDNH0J6OGsj')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      latitude2 = documentSnapshot['latitude'];
      longitude2 = documentSnapshot['longitude'];
      work2 = documentSnapshot['work'];
      name2 = documentSnapshot['name'];
      phoneNumber2 = documentSnapshot['phone number'];

      print(
          'latitude is :$latitude2,longitude is : $longitude2, work is : $work2');
    });
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
  Future<void> getPhoneNumber1() async {
    FirebaseFirestore.instance
        .collection('workers')
        .doc('JhgzxmodhGc3asRNZnVO')
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
  Future<void> getPhoneNumber2() async {
    FirebaseFirestore.instance
        .collection('workers')
        .doc('WtjVrBmgtkDNH0J6OGsj')
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
   calculateDistance(){
    double distanceInMeters = Geolocator.distanceBetween(latitude!, longitude!,
        currentLocation.latitude,currentLocation.longitude);
    double distanceInMeters1 = Geolocator.distanceBetween(latitude1!, longitude1!,
        currentLocation.latitude,currentLocation.longitude);
    double distanceInMeters2 = Geolocator.distanceBetween(latitude2!, longitude2!,
        currentLocation.latitude,currentLocation.longitude);
    print('distance is$distanceInMeters,ditance1 is: $distanceInMeters1 ,distance2 is: $distanceInMeters2');
    distance=distanceInMeters;
    distance1=distanceInMeters1;
    distance2=distanceInMeters2;
  }
}
