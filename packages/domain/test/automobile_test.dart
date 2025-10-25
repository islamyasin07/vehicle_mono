import 'package:test/test.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/engine.dart';
import 'package:domain/models/automobile.dart';

void main() {
  test('default constructor has safe defaults', () {
    final a = Automobile();
    expect(a.manufactureCompany, '');
    expect(a.model, '');
    expect(a.plateNum, 0);
    expect(a.gearType, GearType.normal);
    expect(a.bodySerialNum, 0);
  });

  test('full constructor + getters/setters + bodySerialNum editable', () {
    final e = Engine.full(
      manufacture: 'Toyota',
      manufactureDate: DateTime(2020, 1, 1),
      model: '2ZR',
      capacity: 1800,
      cylinders: 4,
      fuelType: FuelType.gasoline,
    );

    final a = Automobile.full(
      manufactureCompany: 'Toyota',
      manufactureDate: DateTime(2021, 5, 10),
      model: 'Corolla',
      engine: e,
      plateNum: 1234,
      gearType: GearType.automatic,
      bodySerialNum: 777,
    );

    expect(a.manufactureCompany, 'Toyota');
    expect(a.plateNum, 1234);
    expect(a.bodySerialNum, 777);

    a.bodySerialNum = 999;
    expect(a.bodySerialNum, 999);
  });

  test('toJson/fromJson roundtrip', () {
    final e = Engine.full(
      manufacture: 'BMW',
      manufactureDate: DateTime(2022, 2, 2),
      model: 'B48',
      capacity: 2000,
      cylinders: 4,
      fuelType: FuelType.gasoline,
    );

    final a = Automobile.full(
      manufactureCompany: 'BMW',
      manufactureDate: DateTime(2023, 3, 3),
      model: '320i',
      engine: e,
      plateNum: 5555,
      gearType: GearType.normal,
      bodySerialNum: 42,
    );

    final json = a.toJson();
    final copy = Automobile.fromJson(json);

    expect(copy.manufactureCompany, 'BMW');
    expect(copy.plateNum, 5555);
    expect(copy.bodySerialNum, 42);
    expect(copy.engine.model, 'B48');
  });
}
