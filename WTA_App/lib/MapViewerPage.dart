import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapViewerPage extends StatelessWidget {
  const MapViewerPage(
      {super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  _onMapCreated(MapboxMap mapboxMap) {
    var map = mapboxMap;
    map.location.updateSettings(LocationComponentSettings(enabled: true));
  }

  @override
  Widget build(BuildContext context) {
    //TODO: stop making this hard-coded in
    String ACCESS_TOKEN =
        'pk.eyJ1Ijoid2I0OTIiLCJhIjoiY2xncG1hcGJ5MHZ1ODNwbWticWpwdnpjNSJ9.7Np6B2VQQ52s_42friJTOA';
    return Scaffold(
      appBar: AppBar(
        title: Text("Return to previous page"),
        titleTextStyle:
            DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
      ),
      body: MapWidget(
        key: ValueKey("mapWidget"),
        resourceOptions: ResourceOptions(accessToken: ACCESS_TOKEN),
        cameraOptions: CameraOptions(
            center: Point(coordinates: Position(longitude, latitude)).toJson(),
            zoom: 15.0),
        styleUri: MapboxStyles.OUTDOORS,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}
