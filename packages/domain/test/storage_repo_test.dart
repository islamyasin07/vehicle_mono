import 'dart:io';
import 'package:test/test.dart';

import 'package:domain/models/enums.dart';
import 'package:domain/models/engine.dart';
import 'package:domain/models/car.dart';
import 'package:domain/models/motorcycle.dart';
import 'package:domain/models/truck.dart';
import 'package:domain/data/storage_service.dart';
import 'package:domain/data/repo.dart';

Engine mkEngine(String brand) => Engine.full(
      manufacture: brand,
      manufactureDate: DateTime(2020, 1, 1),
      model: 'E',
      capacity: 1500,
      cylinders: 4,
      fuelType: FuelType.gasoline,
    );

void main() {
  late Directory tmp;
  setUp(() {
    tmp = Directory.systemTemp.createTempSync('veh_test_');
  });

  tearDown(() {
    if (tmp.existsSync()) {
      tmp.deleteSync(recursive: true);
    }
  });

  test('StorageService save/load roundtrip', () async {
    final storage = StorageService(tmp);
    final repo = VehicleRepository(storage);

    repo.addCar(Car.full(
      manufactureCompany: 'BMW',
      manufactureDate: DateTime(2022, 2, 2),
      model: 'M3',
      engine: mkEngine('BMW'),
      plateNum: 1111,
      gearType: GearType.automatic,
      bodySerialNum: 10,
      length: 479,
      width: 190,
      color: 'blue',
      chairNum: 5,
      isFurnitureLeather: true,
    ));

    repo.addMotorcycle(Motorcycle.full(
      manufactureCompany: 'Yamaha',
      manufactureDate: DateTime(2021, 1, 1),
      model: 'R3',
      engine: mkEngine('Yamaha'),
      plateNum: 2222,
      gearType: GearType.normal,
      bodySerialNum: 20,
      tierDiameter: 17.0,
      length: 2.1,
    ));

    repo.addTruck(Truck.full(
      manufactureCompany: 'MAN',
      manufactureDate: DateTime(2020, 5, 5),
      model: 'TGX',
      engine: mkEngine('MAN'),
      plateNum: 3333,
      gearType: GearType.normal,
      bodySerialNum: 30,
      length: 1000,
      width: 250,
      color: 'red',
      freeWeight: 7.5,
      fullWeight: 18.0,
    ));

    await repo.save();

    final repo2 = VehicleRepository(StorageService(tmp));
    await repo2.load();

    expect(repo2.cars.length, 1);
    expect(repo2.motorcycles.length, 1);
    expect(repo2.trucks.length, 1);

    expect(repo2.cars.first.model, 'M3');
    expect(repo2.motorcycles.first.tierDiameter, closeTo(17.0, 1e-6));
    expect(repo2.trucks.first.fullWeight, closeTo(18.0, 1e-6));
  });

  test('Repository CRUD + insert', () async {
    final repo = VehicleRepository(StorageService(tmp));

    repo.addCar(Car.full(
      manufactureCompany: 'Toyota',
      manufactureDate: DateTime(2021, 1, 1),
      model: 'Corolla',
      engine: mkEngine('Toyota'),
      plateNum: 4444,
      gearType: GearType.normal,
      bodySerialNum: 77,
      length: 440,
      width: 175,
      color: 'white',
      chairNum: 5,
      isFurnitureLeather: false,
    ));
    repo.insertCar(
        0,
        Car.full(
          manufactureCompany: 'Toyota',
          manufactureDate: DateTime(2020, 1, 1),
          model: 'Yaris',
          engine: mkEngine('Toyota'),
          plateNum: 5555,
          gearType: GearType.normal,
          bodySerialNum: 78,
          length: 410,
          width: 169,
          color: 'silver',
          chairNum: 5,
          isFurnitureLeather: false,
        ));

    expect(repo.cars.first.model, 'Yaris');
    repo.updateCar(1, repo.cars.first);
    repo.deleteCarAt(0);
    expect(repo.cars.length, 1);
  });
}
