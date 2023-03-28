import 'package:fen_ghadi/models/bus.dart';
import 'package:latlong2/latlong.dart';

class BusStation {
  final String name;
  final LatLng location;
  final List<Bus> buss;

  BusStation(this.name, this.location, this.buss);
}