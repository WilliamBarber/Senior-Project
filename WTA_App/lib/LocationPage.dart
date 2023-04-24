import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:location/location.dart';


class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late Future<LocationData> _location;

  MapboxMap? map;

  _onMapCreated(MapboxMap mapboxMap) {
    this.map = mapboxMap;
    map?.location.updateSettings(LocationComponentSettings(enabled: true));
  }

  @override
  void initState(){
    super.initState();
        _location = getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: stop making this hard-coded in
    //TODO: add permissions request (await Permission.locationWhenInUse.request();)
    String ACCESS_TOKEN =
        'pk.eyJ1Ijoid2I0OTIiLCJhIjoiY2xncG1hcGJ5MHZ1ODNwbWticWpwdnpjNSJ9.7Np6B2VQQ52s_42friJTOA';
    return Scaffold(
      appBar: AppBar(
        title: Text("Attach Location"),
        titleTextStyle:
            DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
      ),
      body: FutureBuilder<LocationData>(
        future: _location,
        builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading, please wait...'),
            );
          }
          else {
            final currentLocation = snapshot.data;
            return MapWidget(
              key: ValueKey("mapWidget"),
              resourceOptions: ResourceOptions(accessToken: ACCESS_TOKEN),
               cameraOptions: CameraOptions(center: Point(coordinates: Position(currentLocation?.longitude as num, currentLocation?.latitude as num)).toJson(), zoom: 15.0),
               styleUri: MapboxStyles.OUTDOORS,
               onMapCreated: _onMapCreated,
            );
          }
        }
      ),
    );
  }
  Future<LocationData> getCurrentLocation() async {
    print('************location attempt***************');
    final location = Location();
    LocationData currentLocation = await location.getLocation();
    print('************location get***************');
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _location = location.getLocation();
        map?.setCamera(CameraOptions(
            center: Point(coordinates: Position(currentLocation.longitude as num, currentLocation.latitude as num)).toJson(),
            zoom: 15.0));
        map?.loadStyleURI(MapboxStyles.OUTDOORS);
      });
    });
    return currentLocation;
  }
}




