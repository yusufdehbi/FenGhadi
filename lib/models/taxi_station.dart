import 'package:fen_ghadi/models/taxi.dart';
import 'package:latlong2/latlong.dart';

class TaxiStation {
  final String name;
  final LatLng location;
  final List<TaxiStation> taxiStations = [];
  final List<Taxi> taxiss;

  TaxiStation({
    required this.name,
    required this.location,
    required this.taxiss,
  });
}
