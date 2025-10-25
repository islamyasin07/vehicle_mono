import 'engine.dart';
import 'enums.dart';

class Automobile {
  String _manufactureCompany;
  DateTime _manufactureDate;
  String _model;
  Engine _engine;
  int _plateNum;
  GearType _gearType;
  int _bodySerialNum;

  // Default constructor
  Automobile()
      : _manufactureCompany = '',
        _manufactureDate = DateTime.fromMillisecondsSinceEpoch(0),
        _model = '',
        _engine = Engine(),
        _plateNum = 0,
        _gearType = GearType.normal,
        _bodySerialNum = 0;

  // Full constructor
  Automobile.full({
    required String manufactureCompany,
    required DateTime manufactureDate,
    required String model,
    required Engine engine,
    required int plateNum,
    required GearType gearType,
    required int bodySerialNum,
  })  : _manufactureCompany = manufactureCompany,
        _manufactureDate = manufactureDate,
        _model = model,
        _engine = engine,
        _plateNum = plateNum,
        _gearType = gearType,
        _bodySerialNum = bodySerialNum;

  // Getters / Setters
  String get manufactureCompany => _manufactureCompany;
  set manufactureCompany(String v) => _manufactureCompany = v;

  DateTime get manufactureDate => _manufactureDate;
  set manufactureDate(DateTime v) => _manufactureDate = v;

  String get model => _model;
  set model(String v) => _model = v;

  Engine get engine => _engine;
  set engine(Engine v) => _engine = v;

  int get plateNum => _plateNum;
  set plateNum(int v) => _plateNum = v;

  GearType get gearType => _gearType;
  set gearType(GearType v) => _gearType = v;

  int get bodySerialNum => _bodySerialNum;
  set bodySerialNum(int v) => _bodySerialNum = v;

  Map<String, dynamic> toJson() => {
        'manufactureCompany': _manufactureCompany,
        'manufactureDate': _manufactureDate.toIso8601String(),
        'model': _model,
        'engine': _engine.toJson(),
        'plateNum': _plateNum,
        'gearType': _gearType.name,
        'bodySerialNum': _bodySerialNum,
      };

  factory Automobile.fromJson(Map<String, dynamic> json) => Automobile.full(
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
      );

  Automobile copyWith({
    String? manufactureCompany,
    DateTime? manufactureDate,
    String? model,
    Engine? engine,
    int? plateNum,
    GearType? gearType,
    int? bodySerialNum,
  }) =>
      Automobile.full(
        manufactureCompany: manufactureCompany ?? _manufactureCompany,
        manufactureDate: manufactureDate ?? _manufactureDate,
        model: model ?? _model,
        engine: engine ?? _engine,
        plateNum: plateNum ?? _plateNum,
        gearType: gearType ?? _gearType,
        bodySerialNum: bodySerialNum ?? _bodySerialNum,
      );
}
