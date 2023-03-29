import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MainMap extends StatefulWidget {
  final List<Marker> gettedMarkers;
  final LatLng? start;
  final LatLng? end;
  final List<LatLng>? listPoints;
  const MainMap({
    super.key,
    required this.gettedMarkers,
    this.start,
    this.end,
    this.listPoints,
  });

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  List<LatLng> routpoints = [LatLng(52.05884, -1.345583)];

// getRoutes(LatLng start, LatLng end) async {

//     //start latitude
//     var v1 = start.latitude;
//     //start longitude
//     var v2 = start.longitude;
//     //end latitude
//     var v3 = end.latitude;
//     //end longitude
//     var v4 = end.longitude;

//     // i think this is the one responsive of the routing
//     // get the url
//     var url = Uri.parse(
//         'http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full');
//     // parse the response
//     var response = await http.get(url);
//     print(response.body);
//     setState(() {
//       routpoints = [];
//       var ruter =
//           jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];
//       for (int i = 0; i < ruter.length; i++) {
//         var reep = ruter[i].toString();
//         reep = reep.replaceAll("[", "");
//         reep = reep.replaceAll("]", "");
//         var lat1 = reep.split(',');
//         var long1 = reep.split(",");
//         routpoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
//       }
//       // show and hide the map
//       print("here here" + routpoints.toString());
//     });
//   }

  Future<List<LatLng>> gettingRoutes(List<LatLng> points) async {
    String url = "http://router.project-osrm.org/route/v1/driving/";
    for (int i = 0; i < points.length; i++) {
      if (i > 0) url += ";";
      url += "${points[i].longitude},${points[i].latitude}";
    }
    url += "?steps=true&annotations=true&geometries=geojson&overview=full";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    var routeCoordinates = jsonData['routes'][0]['geometry']['coordinates'];

    List<LatLng> routePoints = [];
    for (int i = 0; i < routeCoordinates.length; i++) {
      var reep = routeCoordinates[i].toString();
      reep = reep.replaceAll("[", "");
      reep = reep.replaceAll("]", "");
      var lat1 = reep.split(',');
      var long1 = reep.split(",");
      routePoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
    }

    return routePoints;
  }

  getRoutes(LatLng start, LatLng end) async {
    //getting the location in list i don't know why and using the first index from it.
    // List<Location> start_l =
    //     await locationFromAddress(start.text);
    // List<Location> end_l =
    //     await locationFromAddress(end.text);

    //share location data to 4 variable (double) each one have latitude or longitude
    // var v1 = start_l[0].latitude;
    // var v2 = start_l[0].longitude;
    // var v3 = end_l[0].latitude;
    // var v4 = end_l[0].longitude;

    //start latitude
    var v1 = start.latitude;
    //start longitude
    var v2 = start.longitude;
    //end latitude
    var v3 = end.latitude;
    //end longitude
    var v4 = end.longitude;

    // i think this is the one responsive of the routing
    //! get the url
    var url = Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full');
    //! parse the response
    var response = await http.get(url);
    print(response.body);
    setState(() {
      routpoints = [];
      var ruter =
          jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];
      for (int i = 0; i < ruter.length; i++) {
        var reep = ruter[i].toString();
        reep = reep.replaceAll("[", "");
        reep = reep.replaceAll("]", "");
        var lat1 = reep.split(',');
        var long1 = reep.split(",");
        routpoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
      }
      //! show and hide the map
      print("here here" + routpoints.toString());
    });
  }

  void fillRoutePoints() async {
    if (widget.listPoints != null && widget.listPoints!.isNotEmpty) {
      routpoints = await gettingRoutes(widget.listPoints!);
    }
    // routpoints = await gettingRoutes([
    //   LatLng(33.974213, -6.834478),
    //   LatLng(33.992646, -6.817955),
    //   LatLng(33.995536, -6.816425),
    //   LatLng(34.009636, -6.835493),
    //   LatLng(34.022622, -6.844591)
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    // print(r"$$$$$$$$$$$$$$---Start---$$$$$$$$$$$");
    // print(widget.start);
    // print(r"$$$$$$$$$$$$$$---end---$$$$$$$$$$$");
    // print(widget.end);
    // if (widget.start != null &&
    //     widget.end != null &&
    //     widget.start != LatLng(0, 0) &&
    //     widget.end != LatLng(0, 0)) {
    //   getRoutes(widget.start!, widget.end!);
    // }
    fillRoutePoints();

    return FlutterMap(
        options: MapOptions(
          zoom: 14.0,
          center: LatLng(33.9715904, -6.8498129),
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          // onLongPress: (tapPosition, point) {
          //   print(point.latitude.toString() +
          //       " _____ " +
          //       point.longitude.toString());
          // },
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=c729f1b69fd24f8ea3e3c99785551dd5',
            userAgentPackageName: 'ma.fenghadi.app.fen_ghadi',
          ),
          PolylineLayer(
            polylineCulling: false,
            polylines: [
              Polyline(
                points: routpoints,
                color: Colors.blue,
                strokeWidth: 6,
              ),
            ],
          ),
          MarkerLayer(
            markers: widget.gettedMarkers,
          ),
        ]);
  }
}
