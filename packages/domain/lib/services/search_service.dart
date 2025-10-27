import '../models/car.dart';
import '../models/motorcycle.dart';
import '../models/truck.dart';

class SearchService {
  static List<Car> carsByCompany(List<Car> cars, String company) {
    final q = company.toLowerCase();
    return cars.where((c) {
      return c.manufactureCompany.toLowerCase().contains(q) ||
          c.model.toLowerCase().contains(q);
    }).toList();
  }

  static List<Motorcycle> motorcyclesByCompany(
      List<Motorcycle> motorcycles, String company) {
    final q = company.toLowerCase();
    return motorcycles.where((m) {
      return m.manufactureCompany.toLowerCase().contains(q) ||
          m.model.toLowerCase().contains(q);
    }).toList();
  }

  static List<Truck> trucksByCompany(List<Truck> trucks, String company) {
    final q = company.toLowerCase();
    return trucks.where((t) {
      return t.manufactureCompany.toLowerCase().contains(q) ||
          t.model.toLowerCase().contains(q);
    }).toList();
  }

  static List<T> byPlate<T>(
      List<T> vehicles, int Function(T) getPlate, int plate) {
    return vehicles.where((v) => getPlate(v) == plate).toList();
  }

  static List<T> byDate<T>(
      List<T> vehicles, DateTime Function(T) getDate, DateTime date) {
    // compare by same day (ignore time)
    return vehicles.where((v) {
      final d = getDate(v);
      return d.year == date.year && d.month == date.month && d.day == date.day;
    }).toList();
  }
}
