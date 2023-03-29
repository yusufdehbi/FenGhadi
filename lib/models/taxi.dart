import 'package:fen_ghadi/models/taxi_transportation.dart';

class Taxi {
  String name;
  double price;
  Duration duration;
  List<TaxiTransporation> taxiTransportations = [];

  /// Start Position ///
  /// Finish Position ///
  /// List of Stations Pass From///

  Taxi(this.name, this.price, this.duration);
}
