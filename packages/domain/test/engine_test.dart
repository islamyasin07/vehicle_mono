import 'package:test/test.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/engine.dart';

void main() {
  test('default constructor', () {
    final e = Engine();
    expect(e.manufacture, '');
    expect(e.model, '');
    expect(e.capacity, 0);
    expect(e.cylinders, 0);
    expect(e.fuelType, FuelType.gasoline);
  });

  test('full constructor + json roundtrip', () {
    final e = Engine.full(
      manufacture: 'Toyota',
      manufactureDate: DateTime(2020, 1, 1),
      model: '2ZR-FE',
      capacity: 1800,
      cylinders: 4,
      fuelType: FuelType.gasoline,
    );

    final map = e.toJson();
    final copy = Engine.fromJson(map);

    expect(copy.manufacture, 'Toyota');
    expect(copy.capacity, 1800);
    expect(copy.cylinders, 4);
    expect(copy.fuelType, FuelType.gasoline);
    expect(copy, equals(e));
  });

  test('copyWith', () {
    final e = Engine();
    final e2 = e.copyWith(capacity: 2000, cylinders: 4);
    expect(e2.capacity, 2000);
    expect(e2.cylinders, 4);
    expect(e.capacity, 0); 
  });
}
