import 'package:fen_ghadi/components/transport_data_sheet.dart';
import 'package:fen_ghadi/models/static_data.dart';
import 'package:fen_ghadi/models/tram_stations.dart';
import 'package:fen_ghadi/models/transport_data.dart';
import 'package:flutter/material.dart';
import 'package:fen_ghadi/components/main_map.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../utils/fen_ghadi_icons_icons.dart';
import '../utils/style.dart';

class HomePage extends StatefulWidget {
  final bool isTaxiChecked;
  final bool isBusChecked;
  final bool isTramChecked;
  const HomePage(
      {super.key,
      required this.isTaxiChecked,
      required this.isBusChecked,
      required this.isTramChecked});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  void _checkLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _getLocation();
  }

  void _getLocation() async {
    try {
      _locationData = await location.getLocation();
      setState(() {});
    } catch (e) {
      print('Could not get the user\'s location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // void showTransportSheet(String name, Duration duration, double price,
    //     IconData icon, Color color) {
    //   showModalBottomSheet<void>(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return TransportDataSheet(
    //           name: name,
    //           duration: duration,
    //           price: price,
    //           icon: icon,
    //           color: color);
    //     },
    //   );
    // }

    //Markers Taxi + Bus + Tram
    List<Marker> taxiMarkers = StaticData.taxiStations
        .map(
          (taxiStation) => Marker(
            point: taxiStation.location,
            builder: ((context) => InkResponse(
                  onTap: () {
                    Fluttertoast.showToast(msg: taxiStation.name);
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return TransportDataSheet(
                          transportData: taxiStation.taxiss
                              .map(
                                (taxi) => TransportData(
                                  taxi.name,
                                  taxi.duration,
                                  taxi.price,
                                  FenGhadiIcons.taxi,
                                  fgYellow,
                                ),
                              )
                              .toList(),
                        );
                      },
                    );
                  },
                  child: Icon(
                    FenGhadiIcons.marker_taxi,
                    size: 50.0,
                    color: fgOrange,
                  ),
                )),
          ),
        )
        .toList();
    List<Marker> busMarkers = StaticData.busStations
        .map(
          (busStation) => Marker(
            point: busStation.location,
            builder: (ctx) => InkResponse(
              onTap: () {
                Fluttertoast.showToast(msg: busStation.name);
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return TransportDataSheet(
                      transportData: busStation.buss
                          .map(
                            (bus) => TransportData(
                              bus.name,
                              bus.duration,
                              bus.price,
                              FenGhadiIcons.bus,
                              fgBlue,
                            ),
                          )
                          .toList(),
                    );
                  },
                );
              },
              child: Icon(
                FenGhadiIcons.marker_bus,
                size: 50.0,
                color: fgBlue,
              ),
            ),
          ),
        )
        .toList();
    List<Marker> tramMarkers = StaticData.tramStations
        .map(
          (tramStation) => Marker(
            point: tramStation.location,
            builder: (ctx) => InkResponse(
              onTap: () {
                Fluttertoast.showToast(msg: tramStation.name);
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return TransportDataSheet(
                      transportData: tramStation.trams
                          .map(
                            (tram) => TransportData(
                              tram.name,
                              tram.duration,
                              tram.price,
                              FenGhadiIcons.tram,
                              fgRed,
                            ),
                          )
                          .toList(),
                    );
                  },
                );
              },
              child: Icon(
                FenGhadiIcons.marker_tram,
                size: 50.0,
                color: fgRed,
              ),
            ),
          ),
        )
        .toList();

    //Combining Markers
    List<Marker> markers = [];
    if (widget.isBusChecked) markers += busMarkers;
    if (widget.isTaxiChecked) markers += taxiMarkers;
    if (widget.isTramChecked) markers += tramMarkers;

    //show position in map
    if (_locationData != null) {
      markers.add(
        Marker(
          point: LatLng(
              _locationData?.latitude ?? 0, _locationData?.longitude ?? 0),
          builder: (ctx) => const Icon(
            Icons.location_on_rounded,
            color: Colors.red,
            size: 30.0,
          ),
        ),
      );
    }

    //Bottom Sheet

    return Scaffold(
      body: MainMap(
        gettedMarkers: markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.my_location_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

// class BottomSheetTransport extends StatelessWidget {
//   const BottomSheetTransport({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         child: const Text('showModalBottomSheet'),
//         onPressed: () {
//           showModalBottomSheet<void>(
//             context: context,
//             builder: (BuildContext context) {
//               return SizedBox(
//                 height: 200,
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       const Text('Modal BottomSheet'),
//                       ElevatedButton(
//                         child: const Text('Close BottomSheet'),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
