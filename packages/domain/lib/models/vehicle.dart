import 'automobile.dart';
import 'engine.dart';
import 'enums.dart';

class Vehicle extends Automobile {
  int _length;
  int _width;
  String _color;

  // Defult
  Vehicle()
      : _length = 0,
        _width = 0,
        _color = '',
        super();

  Vehicle.full({
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
  })  : _length = length,
        _width = width,
        _color = color,
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
  int get length => _length;
  set length(int v) => _length = v;

  int get width => _width;
  set width(int v) => _width = v;

  String get color => _color;
  set color(String v) => _color = v;

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'length': _length,
        'width': _width,
        'color': _color,
      };

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle.full(
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
      );
}
