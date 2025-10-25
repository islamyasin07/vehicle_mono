import 'vehicle.dart';
import 'engine.dart';
import 'enums.dart';

class Truck extends Vehicle {
  double _freeWeight;
  double _fullWeight;

  // Default
  Truck()
      : _freeWeight = 0,
        _fullWeight = 0,
        super();

  // Full
  Truck.full({
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
    // Truck
    required double freeWeight,
    required double fullWeight,
  })  : _freeWeight = freeWeight,
        _fullWeight = fullWeight,
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
  double get freeWeight => _freeWeight;
  set freeWeight(double v) => _freeWeight = v;

  double get fullWeight => _fullWeight;
  set fullWeight(double v) => _fullWeight = v;

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'freeWeight': _freeWeight,
        'fullWeight': _fullWeight,
      };

  factory Truck.fromJson(Map<String, dynamic> json) => Truck.full(
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
        freeWeight: (json['freeWeight'] as num? ?? 0).toDouble(),
        fullWeight: (json['fullWeight'] as num? ?? 0).toDouble(),
      );
}
