import 'package:fen_ghadi/models/bus_transportation.dart';

class Bus {
  String name;
  double price = 5.0;
  Duration duration;
  List<BusTransportation> busTransportations = [];

  /// Start Position ///
  /// Finish Position ///
  /// List of Stations Pass From///

  Bus(this.name, this.duration);
}
