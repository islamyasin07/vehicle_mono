import '../models/car.dart';
import '../models/motorcycle.dart';
import '../models/truck.dart';
import 'storage_service.dart';

class VehicleRepository {
  final StorageService storage;
  VehicleRepository(this.storage);

  final List<Car> cars = [];
  final List<Motorcycle> motorcycles = [];
  final List<Truck> trucks = [];

  Future<void> load() async {
    final res = await storage.loadAll();
    cars
      ..clear()
      ..addAll(res.cars);
    motorcycles
      ..clear()
      ..addAll(res.motorcycles);
    trucks
      ..clear()
      ..addAll(res.trucks);
  }

  Future<void> save() async {
    await storage.saveAll(
      cars: cars,
      motorcycles: motorcycles,
      trucks: trucks,
    );
  }

  // CRUD
  void addCar(Car v) => cars.add(v);
  void addMotorcycle(Motorcycle v) => motorcycles.add(v);
  void addTruck(Truck v) => trucks.add(v);

  void deleteCarAt(int index) => cars.removeAt(index);
  void deleteMotorcycleAt(int index) => motorcycles.removeAt(index);
  void deleteTruckAt(int index) => trucks.removeAt(index);

  void updateCar(int index, Car v) => cars[index] = v;
  void updateMotorcycle(int index, Motorcycle v) => motorcycles[index] = v;
  void updateTruck(int index, Truck v) => trucks[index] = v;

  void insertCar(int index, Car value) => cars.insert(index, value);
  void insertMotorcycle(int index, Motorcycle value) =>
      motorcycles.insert(index, value);
  void insertTruck(int index, Truck value) => trucks.insert(index, value);
}
