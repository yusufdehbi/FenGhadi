import 'package:fen_ghadi/components/item_list_sheet.dart';
import 'package:fen_ghadi/models/bus_station.dart';
import 'package:fen_ghadi/models/taxi_station.dart';
import 'package:fen_ghadi/models/tram_stations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import '../models/transport_data.dart';
import '../utils/style.dart';

class TransportDataSheet extends StatelessWidget {
  final List<TransportData> transportData;
  final bool? isBus;
  final bool? isTram;
  final bool? isTaxi;
  final String stationName;
  final Function(List<BusStation>)? sendBusStations;
  final Function(List<TaxiStation>)? sendTaxiStations;
  final Function(List<TramStation>)? sendTramStations;

  const TransportDataSheet({
    super.key,
    required this.transportData,
    this.isBus,
    this.isTaxi,
    this.isTram,
    required this.stationName,
    this.sendBusStations,
    this.sendTaxiStations,
    this.sendTramStations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: isBus!
          ? fgBlue
          : isTram!
              ? fgRed
              : fgYellow,
      child: Column(children: [
        Expanded(
            flex: 2,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stationName,
                      style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white),
                    ),
                    Icon(
                      transportData[0].icon,
                      size: 70,
                      color: secondaryColor.withOpacity(0.2),
                    ),
                  ],
                ))),
        Expanded(
          flex: 4,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Column(
                children: transportData
                    .map((data) => ItemListSheet(
                          name: data.name,
                          price: data.price,
                          duration: data.duration,
                          pressed: () {
                            if (isBus!) {
                              sendBusStations!(data.bus!.stations);
                            }
                            if (isTram!) {
                              // TODO: send current taxi stations
                            }
                            if (isTaxi!) {
                              // TODO: send current tram stations
                            }
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
