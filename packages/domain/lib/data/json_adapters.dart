import '../models/car.dart';
import '../models/motorcycle.dart';
import '../models/truck.dart';

class CarListAdapter {
  static List<Map<String, dynamic>> toJsonList(List<Car> items) =>
      items.map((e) => e.toJson()).toList(growable: false);

  static List<Car> fromJsonList(List<dynamic>? list) =>
      (list ?? []).map((e) => Car.fromJson(e as Map<String, dynamic>)).toList();
}

class MotorcycleListAdapter {
  static List<Map<String, dynamic>> toJsonList(List<Motorcycle> items) =>
      items.map((e) => e.toJson()).toList(growable: false);

  static List<Motorcycle> fromJsonList(List<dynamic>? list) => (list ?? [])
      .map((e) => Motorcycle.fromJson(e as Map<String, dynamic>))
      .toList();
}

class TruckListAdapter {
  static List<Map<String, dynamic>> toJsonList(List<Truck> items) =>
      items.map((e) => e.toJson()).toList(growable: false);

  static List<Truck> fromJsonList(List<dynamic>? list) => (list ?? [])
      .map((e) => Truck.fromJson(e as Map<String, dynamic>))
      .toList();
}
