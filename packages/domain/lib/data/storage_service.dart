import 'dart:convert';
import 'dart:io';

import '../models/car.dart';
import '../models/motorcycle.dart';
import '../models/truck.dart';
import 'json_adapters.dart';

class StorageService {
  final Directory root;
  StorageService(this.root);

  File get _carsFile => File('${root.path}${Platform.pathSeparator}cars.json');

  File get _motosFile =>
      File('${root.path}${Platform.pathSeparator}motorcycles.json');

  File get _trucksFile =>
      File('${root.path}${Platform.pathSeparator}trucks.json');

  Future<void> saveAll({
    required List<Car> cars,
    required List<Motorcycle> motorcycles,
    required List<Truck> trucks,
  }) async {
    await root.create(recursive: true);
    await _carsFile.writeAsString(jsonEncode(CarListAdapter.toJsonList(cars)));
    await _motosFile.writeAsString(
        jsonEncode(MotorcycleListAdapter.toJsonList(motorcycles)));
    await _trucksFile
        .writeAsString(jsonEncode(TruckListAdapter.toJsonList(trucks)));
  }

  Future<({List<Car> cars, List<Motorcycle> motorcycles, List<Truck> trucks})>
      loadAll() async {
    final cars = await _readList(_carsFile, CarListAdapter.fromJsonList);
    final motos =
        await _readList(_motosFile, MotorcycleListAdapter.fromJsonList);
    final trucks = await _readList(_trucksFile, TruckListAdapter.fromJsonList);
    return (cars: cars, motorcycles: motos, trucks: trucks);
  }

  Future<List<T>> _readList<T>(
    File file,
    List<T> Function(List<dynamic>?) fromJsonList,
  ) async {
    if (!await file.exists()) return <T>[];
    final raw = await file.readAsString();
    if (raw.trim().isEmpty) return <T>[];
    final list = jsonDecode(raw) as List<dynamic>;
    return fromJsonList(list);
  }
}
