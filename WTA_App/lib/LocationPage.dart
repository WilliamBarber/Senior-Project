import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
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
      body: MapWidget(
          resourceOptions: ResourceOptions(accessToken: ACCESS_TOKEN)
      ),
    );
  }
}
