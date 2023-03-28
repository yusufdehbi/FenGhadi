import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MainMap extends StatefulWidget {
  final List<Marker> gettedMarkers;
  const MainMap({super.key, required this.gettedMarkers});

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
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

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: MapOptions(
          zoom: 14.0,
          center: LatLng(33.9715904, -6.8498129),
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=c729f1b69fd24f8ea3e3c99785551dd5',
            userAgentPackageName: 'ma.fenghadi.app.fen_ghadi',
          ),
          MarkerLayer(
            markers: widget.gettedMarkers,
          )
        ]);
  }
}
