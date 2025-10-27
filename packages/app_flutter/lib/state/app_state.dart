import 'package:flutter/foundation.dart';
import 'package:domain/data/repo.dart';
import 'package:domain/models/car.dart';
import 'package:domain/models/motorcycle.dart';
import 'package:domain/models/truck.dart';

class AppState extends ChangeNotifier {
  final VehicleRepository repo;
  AppState(this.repo);

  List<Car> get cars => repo.cars;
  List<Motorcycle> get motorcycles => repo.motorcycles;
  List<Truck> get trucks => repo.trucks;

  Future<void> save() => repo.save();

  // CRUD
  void addCar(Car v) { repo.addCar(v); notifyListeners(); }
  void addMotorcycle(Motorcycle v) { repo.addMotorcycle(v); notifyListeners(); }
  void addTruck(Truck v) { repo.addTruck(v); notifyListeners(); }

  void updateCar(int i, Car v) { repo.updateCar(i, v); notifyListeners(); }
  void updateMotorcycle(int i, Motorcycle v) { repo.updateMotorcycle(i, v); notifyListeners(); }
  void updateTruck(int i, Truck v) { repo.updateTruck(i, v); notifyListeners(); }

  void deleteCarAt(int i) { repo.deleteCarAt(i); notifyListeners(); }
  void deleteMotorcycleAt(int i) { repo.deleteMotorcycleAt(i); notifyListeners(); }
  void deleteTruckAt(int i) { repo.deleteTruckAt(i); notifyListeners(); }

  // Insert at index
  void insertCar(int index, Car v) { repo.insertCar(index, v); notifyListeners(); }
  void insertMotorcycle(int index, Motorcycle v) { repo.insertMotorcycle(index, v); notifyListeners(); }
  void insertTruck(int index, Truck v) { repo.insertTruck(index, v); notifyListeners(); }
}
