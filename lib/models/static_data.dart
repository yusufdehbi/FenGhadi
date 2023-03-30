import 'package:fen_ghadi/models/bus_station.dart';
import 'package:fen_ghadi/models/bus_transportation.dart';
import 'package:fen_ghadi/models/taxi.dart';
import 'package:fen_ghadi/models/taxi_station.dart';
import 'package:fen_ghadi/models/taxi_transportation.dart';
import 'package:fen_ghadi/models/tram.dart';
import 'package:fen_ghadi/models/tram_stations.dart';
import 'package:fen_ghadi/models/tram_transportation.dart';
import 'package:latlong2/latlong.dart';
import 'bus.dart';

class StaticData {
  static List<TaxiStation> taxiStations = [
    TaxiStation(
      name: 'mini park',
      location: LatLng(34.01325, -6.83255),
      taxiss: taxiss,
    ),
    TaxiStation(
      name: 'Hoummane Al Fatouaki',
      location: LatLng(34.159797452248405, -6.399372758969286),
      taxiss: taxiss,
    ),
    TaxiStation(
      name: 'Al Haouz',
      location: LatLng(34.159797452248405, -6.399372758969286),
      taxiss: taxiss,
    ),
    TaxiStation(
      name: 'Abou Bakr Saddik',
      location: LatLng(34.00409861562887, -6.618133412371321),
      taxiss: taxiss,
    ),
    TaxiStation(
      name: 'Moulay Ali Cherif',
      location: LatLng(34.24642957710635, -6.397379671728518),
      taxiss: taxiss,
    ),
    TaxiStation(
      name: 'aéroport ',
      location: LatLng(34.24642957710635, -6.397379671728518),
      taxiss: taxiss,
    ),
    TaxiStation(
      name: 'Airfane ',
      location: LatLng(33.979455, -6.8745913),
      taxiss: taxiss,
    ),
  ];
  static List<BusStation> busStations = [
    BusStation(
      'Takadoum',
      LatLng(33.9742133, -6.8344776),
    ),
    BusStation(
      'Minipark',
      LatLng(33.9926465, -6.8179552),
    ),
    BusStation(
      'Youssofia',
      LatLng(33.99690826804329, -6.815371579299652),
    ),
    BusStation(
      'Medina',
      LatLng(34.0096358, -6.8354934),
    ),
    BusStation(
      'Ocean',
      LatLng(34.0226221, -6.8445908),
    ),
    BusStation(
      'Temara ',
      LatLng(33.9362713, -6.9057512),
    ),
    BusStation(
      'Est ',
      LatLng(34.0515397, -6.8138573),
    ),
    BusStation(
      'Bouknadel',
      LatLng(34.12701860294961, -6.735920939815566),
    ),
  ];
  static List<TramStation> tramStations = [
    TramStation(
      'United Nations station',
      LatLng(33.9972507, -6.8424226),
      trams,
    ),
    TramStation(
      'Bibliothéque Natioanle',
      LatLng(34.0081551, -6.8408133),
      trams,
    ),
    TramStation(
      'GARE RABAT VILLE',
      LatLng(34.0138736, -6.8365325),
      trams,
    ),
    TramStation(
      'Mosque Ashohada',
      LatLng(34.0257096, -6.8411781),
      trams,
    ),
    TramStation(
      'Diar-V',
      LatLng(34.0387004, -6.818563),
      trams,
    ),
    TramStation(
      'Bouzid 1',
      LatLng(34.052404, -6.8117959),
      trams,
    ),
    TramStation(
      'Mazza-v',
      LatLng(34.0685301, -6.7609849),
      trams,
    ),
  ];
  static List<Bus> buss = [
    Bus('L9', const Duration(minutes: 50)),
    Bus('L10', const Duration(minutes: 30)),
    Bus('L37', const Duration(minutes: 60)),
    Bus('L104', const Duration(minutes: 40)),
    Bus('L8', const Duration(minutes: 90)),
    Bus('L102', const Duration(minutes: 10)),
    Bus('L3', const Duration(minutes: 90)),
  ];
  static List<Taxi> taxiss = [
    Taxi('kamra', 5.0, const Duration(minutes: 30)),
    Taxi('Sale El jadida', 10.0, const Duration(minutes: 50)),
    Taxi('temara', 10.0, const Duration(minutes: 60)),
    Taxi('manal', 5.0, const Duration(minutes: 40)),
    Taxi('Ain Aouda', 13.0, const Duration(minutes: 90)),
    Taxi('Takadoum', 5.0, const Duration(minutes: 10)),
  ];
  static List<Tram> trams = [
    Tram('L1', const Duration(minutes: 30)),
    Tram('L2', const Duration(minutes: 50)),
  ];

  static Map<String, Bus> busList = {
    'L102': buss[5],
    'L104': buss[3],
    'L9': buss[0],
    'L10': buss[1],
    'L37': buss[2],
    'L8': buss[4],
    'L3': buss[6],
  };
  static Map<String, BusStation> busStationsList = {
    'Minipark': busStations[1],
    'Takadoum': busStations[0],
    'Youssofia': busStations[2],
    'Medina': busStations[3],
    'Ocean': busStations[4],
    'Temara': busStations[5],
    'Est': busStations[6],
    'Bouknadel': busStations[7],
  };
  static Map<String, Tram> tramList = {
    'L1': trams[0],
    'L2': trams[1],
  };
  static Map<String, TramStation> tramStationList = {
    'United Nations station': tramStations[0],
    'Bibliothéque Natioanle': tramStations[1],
    'GARE RABAT VILLE': tramStations[2],
    'Mosque Ashohada': tramStations[3],
    'Diar-V': tramStations[4],
    'Bouzid 1': tramStations[5],
    'Mazza-v': tramStations[6]
  };

  static List<TaxiTransporation> taxiTransportations = [];
  static List<BusTransportation> busTransportations = [
    //Line 102
    BusTransportation(busList['L102']!, busStationsList['Takadoum']!),
    BusTransportation(busList['L102']!, busStationsList['Minipark']!),
    BusTransportation(busList['L102']!, busStationsList['Youssofia']!),
    BusTransportation(busList['L102']!, busStationsList['Medina']!),
    BusTransportation(busList['L102']!, busStationsList['Ocean']!),
    //Line 37
    BusTransportation(busList['L37']!, busStationsList['Minipark']!),
    BusTransportation(busList['L37']!, busStationsList['Takadoum']!),
    BusTransportation(busList['L37']!, busStationsList['Temara']!),
    //Line 3
    BusTransportation(busList['L3']!, busStationsList['Medina']!),
    BusTransportation(busList['L3']!, busStationsList['Est']!),
    BusTransportation(busList['L3']!, busStationsList['Bouknadel']!),
  ];
  static List<TramTransportation> tramTransportation = [
    //line 1
    TramTransportation(trams[0], tramStations['Takadoum']),
  ];
}
