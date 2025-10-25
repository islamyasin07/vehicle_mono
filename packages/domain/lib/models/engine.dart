import 'enums.dart';

class Engine {
  String _manufacture;
  DateTime _manufactureDate;
  String _model;
  int _capacity;
  int _cylinders;
  FuelType _fuelType;

  // Default constructor
  Engine()
      : _manufacture = '',
        _manufactureDate = DateTime.fromMillisecondsSinceEpoch(0),
        _model = '',
        _capacity = 0,
        _cylinders = 0,
        _fuelType = FuelType.gasoline;

  //  constructor
  Engine.full({
    required String manufacture,
    required DateTime manufactureDate,
    required String model,
    required int capacity,
    required int cylinders,
    required FuelType fuelType,
  })  : _manufacture = manufacture,
        _manufactureDate = manufactureDate,
        _model = model,
        _capacity = capacity,
        _cylinders = cylinders,
        _fuelType = fuelType;

  String get manufacture => _manufacture;
  set manufacture(String v) => _manufacture = v;

  DateTime get manufactureDate => _manufactureDate;
  set manufactureDate(DateTime v) => _manufactureDate = v;

  String get model => _model;
  set model(String v) => _model = v;

  int get capacity => _capacity;
  set capacity(int v) => _capacity = v;

  int get cylinders => _cylinders;
  set cylinders(int v) => _cylinders = v;

  FuelType get fuelType => _fuelType;
  set fuelType(FuelType v) => _fuelType = v;

  Engine copyWith({
    String? manufacture,
    DateTime? manufactureDate,
    String? model,
    int? capacity,
    int? cylinders,
    FuelType? fuelType,
  }) {
    return Engine.full(
      manufacture: manufacture ?? _manufacture,
      manufactureDate: manufactureDate ?? _manufactureDate,
      model: model ?? _model,
      capacity: capacity ?? _capacity,
      cylinders: cylinders ?? _cylinders,
      fuelType: fuelType ?? _fuelType,
    );
  }

  Map<String, dynamic> toJson() => {
        'manufacture': _manufacture,
        'manufactureDate': _manufactureDate.toIso8601String(),
        'model': _model,
        'capacity': _capacity,
        'cylinders': _cylinders,
        'fuelType': _fuelType.name,
      };

  factory Engine.fromJson(Map<String, dynamic> json) => Engine.full(
        manufacture: json['manufacture'] as String? ?? '',
        manufactureDate: DateTime.parse(
          json['manufactureDate'] as String? ?? '1970-01-01T00:00:00Z',
        ),
        model: json['model'] as String? ?? '',
        capacity: (json['capacity'] as num? ?? 0).toInt(),
        cylinders: (json['cylinders'] as num? ?? 0).toInt(),
        fuelType: FuelType.values.firstWhere(
          (e) => e.name == json['fuelType'],
          orElse: () => FuelType.gasoline,
        ),
      );

  @override
  bool operator ==(Object other) {
    return other is Engine &&
        other._manufacture == _manufacture &&
        other._manufactureDate == _manufactureDate &&
        other._model == _model &&
        other._capacity == _capacity &&
        other._cylinders == _cylinders &&
        other._fuelType == _fuelType;
  }

  @override
  int get hashCode => Object.hash(
        _manufacture,
        _manufactureDate,
        _model,
        _capacity,
        _cylinders,
        _fuelType,
      );
}
