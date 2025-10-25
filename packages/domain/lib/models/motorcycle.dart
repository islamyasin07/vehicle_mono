import 'automobile.dart';
import 'engine.dart';
import 'enums.dart';

class Motorcycle extends Automobile {
  double _tierDiameter;
  double _length;

  //
  Motorcycle()
      : _tierDiameter = 0,
        _length = 0,
        super();

  Motorcycle.full({
    // Automobile
    required String manufactureCompany,
    required DateTime manufactureDate,
    required String model,
    required Engine engine,
    required int plateNum,
    required GearType gearType,
    required int bodySerialNum,
    // Motorcycle
    required double tierDiameter,
    required double length,
  })  : _tierDiameter = tierDiameter,
        _length = length,
        super.full(
          manufactureCompany: manufactureCompany,
          manufactureDate: manufactureDate,
          model: model,
          engine: engine,
          plateNum: plateNum,
          gearType: gearType,
          bodySerialNum: bodySerialNum,
        );

  // Getters/Setters
  double get tierDiameter => _tierDiameter;
  set tierDiameter(double v) => _tierDiameter = v;

  double get length => _length;
  set length(double v) => _length = v;

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'tierDiameter': _tierDiameter,
        'length': _length,
      };

  factory Motorcycle.fromJson(Map<String, dynamic> json) => Motorcycle.full(
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
        tierDiameter: (json['tierDiameter'] as num? ?? 0).toDouble(),
        length: (json['length'] as num? ?? 0).toDouble(),
      );
}
