import 'package:test/test.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/engine.dart';
import 'package:domain/models/vehicle.dart';
import 'package:domain/models/car.dart';
import 'package:domain/models/truck.dart';
import 'package:domain/models/motorcycle.dart';

Engine mkEngine(String brand) => Engine.full(
      manufacture: brand,
      manufactureDate: DateTime(2020, 1, 1),
      model: 'X',
      capacity: 1500,
      cylinders: 4,
      fuelType: FuelType.gasoline,
    );

void main() {
  test('Vehicle json roundtrip', () {
    final v = Vehicle.full(
      manufactureCompany: 'Toyota',
      manufactureDate: DateTime(2021, 1, 1),
      model: 'Yaris',
      engine: mkEngine('Toyota'),
      plateNum: 1111,
      gearType: GearType.normal,
      bodySerialNum: 7,
      length: 400,
      width: 170,
      color: 'white',
    );

    final copy = Vehicle.fromJson(v.toJson());
    expect(copy.model, 'Yaris');
    expect(copy.bodySerialNum, 7);
    expect(copy.color, 'white');
  });

  test('Car json roundtrip + bodySerialNum editable', () {
    final c = Car.full(
      manufactureCompany: 'BMW',
      manufactureDate: DateTime(2022, 2, 2),
      model: 'M3',
      engine: mkEngine('BMW'),
      plateNum: 2222,
      gearType: GearType.automatic,
      bodySerialNum: 42,
      length: 479,
      width: 190,
      color: 'blue',
      chairNum: 5,
      isFurnitureLeather: true,
    );

    final map = c.toJson();
    final copy = Car.fromJson(map);
    expect(copy.chairNum, 5);
    expect(copy.isFurnitureLeather, true);

    copy.bodySerialNum = 99; // inherited writable
    expect(copy.bodySerialNum, 99);
  });

  test('Truck json roundtrip', () {
    final t = Truck.full(
      manufactureCompany: 'MAN',
      manufactureDate: DateTime(2019, 3, 3),
      model: 'TGX',
      engine: mkEngine('MAN'),
      plateNum: 3333,
      gearType: GearType.normal,
      bodySerialNum: 5,
      length: 1000,
      width: 250,
      color: 'red',
      freeWeight: 7.5,
      fullWeight: 18.0,
    );
    final copy = Truck.fromJson(t.toJson());
    expect(copy.freeWeight, closeTo(7.5, 1e-6));
    expect(copy.fullWeight, closeTo(18.0, 1e-6));
  });

  test('Motorcycle json roundtrip', () {
    final m = Motorcycle.full(
      manufactureCompany: 'Yamaha',
      manufactureDate: DateTime(2020, 6, 6),
      model: 'R3',
      engine: mkEngine('Yamaha'),
      plateNum: 4444,
      gearType: GearType.normal,
      bodySerialNum: 3,
      tierDiameter: 17.0,
      length: 2.1,
    );
    final copy = Motorcycle.fromJson(m.toJson());
    expect(copy.tierDiameter, closeTo(17.0, 1e-6));
    expect(copy.length, closeTo(2.1, 1e-6));
  });
}
