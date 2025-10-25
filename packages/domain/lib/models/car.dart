import 'vehicle.dart';
import 'engine.dart';
import 'enums.dart';

class Car extends Vehicle {
  int _chairNum;
  bool _isFurnitureLeather;

  Car()
      : _chairNum = 0,
        _isFurnitureLeather = false,
        super();

  Car.full({
    // Automobile
    required String manufactureCompany,
    required DateTime manufactureDate,
    required String model,
    required Engine engine,
    required int plateNum,
    required GearType gearType,
    required int bodySerialNum,
    // Vehicle
    required int length,
    required int width,
    required String color,
    // Car
    required int chairNum,
    required bool isFurnitureLeather,
  })  : _chairNum = chairNum,
        _isFurnitureLeather = isFurnitureLeather,
        super.full(
          manufactureCompany: manufactureCompany,
          manufactureDate: manufactureDate,
          model: model,
          engine: engine,
          plateNum: plateNum,
          gearType: gearType,
          bodySerialNum: bodySerialNum,
          length: length,
          width: width,
          color: color,
        );

  // Getters/Setters
  int get chairNum => _chairNum;
  set chairNum(int v) => _chairNum = v;

  bool get isFurnitureLeather => _isFurnitureLeather;
  set isFurnitureLeather(bool v) => _isFurnitureLeather = v;

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'chairNum': _chairNum,
        'isFurnitureLeather': _isFurnitureLeather,
      };

  factory Car.fromJson(Map<String, dynamic> json) => Car.full(
        manufactureCompany: json['manufactureCompany'] as String? ?? '',
        manufactureDate: DateTime.parse(
          json['manufactureDate'] as String? ?? '1970-01-01T00:00:00Z',
        ),
        model: json['model'] as String? ?? '',
        engine: Engine.fromJson(json['engine'] as Map<String, dynamic>? ?? {}),
        plateNum: (json['plateNum'] as num? ?? 0).toInt(),
        gearType: GearType.values.firstWhere(
          (e) => e.name == json['gearType'],
          orElse: () => GearType.normal,
        ),
        bodySerialNum: (json['bodySerialNum'] as num? ?? 0).toInt(),
        length: (json['length'] as num? ?? 0).toInt(),
        width: (json['width'] as num? ?? 0).toInt(),
        color: json['color'] as String? ?? '',
        chairNum: (json['chairNum'] as num? ?? 0).toInt(),
        isFurnitureLeather: json['isFurnitureLeather'] as bool? ?? false,
      );
}
