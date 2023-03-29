import 'dart:convert';

import 'package:fen_ghadi/components/google_autocompete.dart';
import 'package:fen_ghadi/components/transport_data_sheet.dart';
import 'package:fen_ghadi/models/bus_station.dart';
import 'package:fen_ghadi/models/bus_transportation.dart';
import 'package:fen_ghadi/models/static_data.dart';
import 'package:fen_ghadi/models/taxi_transportation.dart';
import 'package:fen_ghadi/models/transport_data.dart';
import 'package:flutter/material.dart';
import 'package:fen_ghadi/components/main_map.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

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
  //! Start: Get Location Permission
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
      setState(() {
        _start =
            LatLng(_locationData?.latitude ?? 0, _locationData?.longitude ?? 0);
      });
    } catch (e) {
      print('Could not get the user\'s location: $e');
    }
  }
  //! End : getting permission

  List<Marker> markers = [];
  Marker? userLocation;
  Marker? userDestination;
  List<LatLng> passedRoutePoints = [];

  //Routing
  LatLng _start = LatLng(0, 0);
  LatLng _end = LatLng(0, 0);
  LatLng _destination = LatLng(0, 0);

  Future<void> getLocationFromPlaceId(String placeId, String apiKey) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> jsonData = jsonDecode(response.body);

    Map<String, double> location = {
      "lat": jsonData["result"]["geometry"]["location"]["lat"],
      "lng": jsonData["result"]["geometry"]["location"]["lng"]
    };
    // print(
    //     "___________________________im here______________________________");
    // print(location['lat'].toString());
    _destination = LatLng(jsonData["result"]["geometry"]["location"]["lat"],
        jsonData["result"]["geometry"]["location"]["lng"]);
    setState(() {
      // markers.add(
      //   Marker(
      //     point: LatLng(location['lat']!, location['lng']!),
      //     builder: (context) => const Icon(
      //       Icons.add_location_alt,
      //       color: Colors.green,
      //       size: 40.0,
      //     ),
      //   ),
      // );

      userDestination = Marker(
        point: LatLng(location['lat']!, location['lng']!),
        builder: (context) => const Icon(
          Icons.add_location_alt,
          color: Colors.green,
          size: 40.0,
        ),
      );
    });

    // return location;
  }

  @override
  Widget build(BuildContext context) {
    // //!Start : Fill Transportation Values
    // //fill bus transportation with l102 - thier
    // StaticData.busTransportations = StaticData.busStations
    //     .map((busStation) =>
    //         BusTransportation(StaticData.busList['L102']!, busStation))
    //     .toList();
    // // StaticData.busList['L102']?.busTransportations =
    // //     StaticData.busTransportations.contains(element);

    // StaticData.busTransportations.clear();
    // print(StaticData.busTransportations.length);
    // StaticData.busTransportations.forEach(
    //   (busTransportation) {
    //     // if (busTransportation.bus == StaticData.busList['L102']) {
    //     // StaticData.busList['L102']?.busTransportations.add(busTransportation);
    //     print(StaticData.busTransportations);
    //     // }
    //   },
    // );
    // print('________________ Bus Transportaion __________________');
    // print(StaticData.busTransportations.length);
    // print(
    //     '________________ Bus Transportaion FROM The Bus Class __________________');
    // StaticData.busList['L102']?.busTransportations.forEach(
    //   (element) {
    //     print(element.busStation.name);
    //   },
    // );
    // StaticData.busList['L102']?.busTransportations = [];
    StaticData.busTransportations = [
      BusTransportation(
          StaticData.busList['L102']!, StaticData.busStationsList['Takadoum']!),
      BusTransportation(
          StaticData.busList['L102']!, StaticData.busStationsList['Minipark']!),
      BusTransportation(StaticData.busList['L102']!,
          StaticData.busStationsList['Youssofia']!),
      BusTransportation(StaticData.busList['L102']!,
          BusStation("helper", LatLng(33.99722985505664, -6.815488358624003))),
      BusTransportation(
          StaticData.busList['L102']!, StaticData.busStationsList['Medina']!),
      BusTransportation(
          StaticData.busList['L102']!, StaticData.busStationsList['Ocean']!),
    ];
    // print("______ Bus Transportation ________");
    // StaticData.busTransportations.forEach((element) {
    //   if (element.bus == StaticData.busList['L102']) {
    //     print(element.busStation.name);
    //   }
    // });
    StaticData.busList['L102']?.busTransportations =
        StaticData.busTransportations;
    // StaticData.busList['L102']?.busTransportations.forEach((busTrans) {
    //   print(busTrans.bus.name + " \|\| " + busTrans.busStation.name);
    // });
    // //!End
    //Markers Taxi + Bus + Tram
    List<Marker> taxiMarkers = StaticData.taxiStations
        .map(
          (taxiStation) => Marker(
            point: taxiStation.location,
            builder: ((context) => GestureDetector(
                  onDoubleTap: () {
                    Fluttertoast.showToast(msg: 'msg');
                  },
                  onTap: () {
                    print(r"$$$$$$$$$$$$$$$$$$$$$$$$$");
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
                      transportData: busStation.busList
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
    markers.clear();

    //Combining Markers
    if (widget.isBusChecked) markers += busMarkers;
    if (widget.isTaxiChecked) markers += taxiMarkers;
    if (widget.isTramChecked) markers += tramMarkers;

    //show position in map
    if (_locationData != null) {
      userLocation = Marker(
        point:
            LatLng(_locationData?.latitude ?? 0, _locationData?.longitude ?? 0),
        builder: (ctx) => const Icon(
          Icons.location_on_rounded,
          color: Colors.red,
          size: 30.0,
        ),
      );
      markers.add(userLocation!);
    }

    if (userDestination != null) {
      markers.add(userDestination!);
    }

    //show destination in map

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // SearchBar(
          //   onSearch: (searchedCoordinate) {},
          // ),
          MainMap(
            gettedMarkers: markers,
            // start: _start,
            // end: _end,
            listPoints: passedRoutePoints,
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: GoogleAutocomplete(getPlaceId: (str) async {
              await getLocationFromPlaceId(str, apiKey);

              setState(() {
                // fetchPlaceDetails(str);

                print(_locationData);
                print(_destination);
                _start = LatLng(_locationData?.latitude ?? 0,
                    _locationData?.longitude ?? 0);
                _end = LatLng(_destination.latitude, _destination.longitude);
                print("______________start_____________");
                print(_start);
                print("______________end_____________");
                print(_end);
              });
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _getLocation();
            if (_locationData != null) {
              userLocation = Marker(
                point: LatLng(_locationData?.latitude ?? 0,
                    _locationData?.longitude ?? 0),
                builder: (ctx) => const Icon(
                  Icons.location_on_rounded,
                  color: Colors.red,
                  size: 30.0,
                ),
              );
              markers.add(userLocation!);
            }
            passedRoutePoints = StaticData.busList['L102']!.busTransportations
                .map((busTransportation) =>
                    busTransportation.busStation.location)
                .toList();
            print("__________Passed Route Points __________");
            print(passedRoutePoints);
          });
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.my_location_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
