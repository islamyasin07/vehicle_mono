import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/engine.dart';
import 'package:domain/models/car.dart';
import 'package:domain/models/truck.dart';
import 'package:domain/models/motorcycle.dart';
import '../state/app_state.dart';
import 'list_tab.dart';

class EditVehiclePage extends StatefulWidget {
  const EditVehiclePage({super.key});

  @override
  State<EditVehiclePage> createState() => _EditVehiclePageState();
}

class _EditVehiclePageState extends State<EditVehiclePage> {
  final _form = GlobalKey<FormState>();
  TabKind _kind = TabKind.cars;

  // Common automobile
  final _company = TextEditingController();
  final _model = TextEditingController();
  final _plate = TextEditingController();
  final _bodySerial = TextEditingController();
  GearType _gear = GearType.normal;
  DateTime _date = DateTime.now();

  // Engine
  final _engCompany = TextEditingController();
  final _engModel = TextEditingController();
  final _engCap = TextEditingController();
  final _engCyl = TextEditingController();
  FuelType _fuel = FuelType.gasoline;

  // Vehicle common
  final _length = TextEditingController();
  final _width = TextEditingController();
  final _color = TextEditingController();

  // Car
  final _chairs = TextEditingController();
  bool _leather = false;

  // Truck
  final _freeWeight = TextEditingController();
  final _fullWeight = TextEditingController();

  // Motorcycle
  final _tier = TextEditingController();
  final _motoLen = TextEditingController();

  @override
  void dispose() {
    for (final c in [
      _company,
      _model,
      _plate,
      _bodySerial,
      _engCompany,
      _engModel,
      _engCap,
      _engCyl,
      _length,
      _width,
      _color,
      _chairs,
      _freeWeight,
      _fullWeight,
      _tier,
      _motoLen,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const kAnimDuration = Duration(milliseconds: 380);
    final args = ModalRoute.of(
      context,
    )?.settings.arguments; // (TabKind, index) or null
    final isEditing = args is (TabKind, int);
    final app = context.read<AppState>();

    if (args is (TabKind, int)) {
      _kind = args.$1;
      final i = args.$2;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (_kind == TabKind.cars) {
          _hydrateCar(app.cars[i]);
        } else if (_kind == TabKind.trucks) {
          _hydrateTruck(app.trucks[i]);
        } else {
          _hydrateMoto(app.motorcycles[i]);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Create / Edit Vehicle')),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: kAnimDuration,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF373B44), Color(0xFF4286f4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                color: const Color.fromRGBO(255, 255, 255, 0.96),
                elevation: 0,
                borderRadius: BorderRadius.circular(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Form(
                    key: _form,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        SegmentedButton<TabKind>(
                          segments: const [
                            ButtonSegment(
                              value: TabKind.cars,
                              label: Text('Car'),
                            ),
                            ButtonSegment(
                              value: TabKind.motorcycles,
                              label: Text('Motorcycle'),
                            ),
                            ButtonSegment(
                              value: TabKind.trucks,
                              label: Text('Truck'),
                            ),
                          ],
                          selected: {_kind},
                          onSelectionChanged: (s) =>
                              setState(() => _kind = s.first),
                        ),
                        const SizedBox(height: 12),

                        _section('Automobile', [
                          _text(
                            _company,
                            'Manufacture Company',
                            required: true,
                          ),
                          _dateField(),
                          _text(_model, 'Model', required: true),
                          _int(_plate, 'Plate Number'),
                          _int(_bodySerial, 'Body Serial Number (editable)'),
                          _dropdown<GearType>(
                            'Gear Type',
                            _gear,
                            GearType.values,
                            (v) => setState(() => _gear = v!),
                          ),
                        ]),

                        _section('Engine', [
                          _text(_engCompany, 'Engine Manufacture'),
                          _text(_engModel, 'Engine Model'),
                          _int(_engCap, 'Capacity (cc)'),
                          _int(_engCyl, 'Cylinders'),
                          _dropdown<FuelType>(
                            'Fuel Type',
                            _fuel,
                            FuelType.values,
                            (v) => setState(() => _fuel = v!),
                          ),
                        ]),

                        if (_kind != TabKind.motorcycles)
                          _section('Vehicle', [
                            _int(_length, 'Length'),
                            _int(_width, 'Width'),
                            _text(_color, 'Color'),
                          ]),

                        if (_kind == TabKind.cars)
                          _section('Car', [
                            _int(_chairs, 'Chairs'),
                            SwitchListTile(
                              title: const Text('Leather Furniture'),
                              value: _leather,
                              onChanged: (v) => setState(() => _leather = v),
                            ),
                          ]),

                        if (_kind == TabKind.trucks)
                          _section('Truck', [
                            _double(_freeWeight, 'Free Weight'),
                            _double(_fullWeight, 'Full Weight'),
                          ]),

                        if (_kind == TabKind.motorcycles)
                          _section('Motorcycle', [
                            _double(_tier, 'Tier Diameter'),
                            _double(_motoLen, 'Length'),
                          ]),

                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () => _submit(app, args),
                                child: const Text('Save'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _insertAtIndex(app),
                                child: const Text('Insert at Index'),
                              ),
                            ),
                          ],
                        ),
                        if (isEditing) ...[
                          const SizedBox(height: 12),
                          FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.error,
                              foregroundColor: Theme.of(
                                context,
                              ).colorScheme.onError,
                            ),
                            onPressed: () {
                              if (!isEditing) return;
                              final index = (args as dynamic).$2;
                              switch (_kind) {
                                case TabKind.cars:
                                  app.deleteCarAt(index);
                                  break;
                                case TabKind.motorcycles:
                                  app.deleteMotorcycleAt(index);
                                  break;
                                case TabKind.trucks:
                                  app.deleteTruckAt(index);
                                  break;
                              }
                              app.save();
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.delete_forever_rounded),
                            label: const Text('Delete'),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) => Card(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...children.map(
            (w) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: w,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _text(
    TextEditingController c,
    String label, {
    bool required = false,
  }) => TextFormField(
    controller: c,
    decoration: InputDecoration(labelText: label),
    validator: required
        ? (v) => (v == null || v.isEmpty) ? 'Required' : null
        : null,
  );

  Widget _int(TextEditingController c, String label) => TextFormField(
    controller: c,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(labelText: label),
  );

  Widget _double(TextEditingController c, String label) => TextFormField(
    controller: c,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(labelText: label),
  );

  Widget _dropdown<T>(
    String label,
    T value,
    List<T> items,
    ValueChanged<T?> onChanged,
  ) => DropdownButtonFormField<T>(
    initialValue: value,
    items: items
        .map(
          (e) => DropdownMenuItem<T>(
            value: e,
            child: Text(e.toString().split('.').last),
          ),
        )
        .toList(),
    onChanged: onChanged,
    decoration: InputDecoration(labelText: label),
  );

  Widget _dateField() => ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      'Manufacture Date: ${_date.toIso8601String().split('T').first}',
    ),
    trailing: const Icon(Icons.calendar_today),
    onTap: () async {
      final d = await showDatePicker(
        context: context,
        firstDate: DateTime(1970),
        lastDate: DateTime(2100),
        initialDate: _date,
      );
      if (d != null) setState(() => _date = d);
    },
  );

  Engine _buildEngine() => Engine.full(
    manufacture: _engCompany.text,
    manufactureDate: _date,
    model: _engModel.text,
    capacity: int.tryParse(_engCap.text) ?? 0,
    cylinders: int.tryParse(_engCyl.text) ?? 0,
    fuelType: _fuel,
  );

  void _submit(AppState app, Object? args) {
    if (!(_form.currentState?.validate() ?? false)) return;
    final engine = _buildEngine();

    if (_kind == TabKind.cars) {
      final v = Car.full(
        manufactureCompany: _company.text,
        manufactureDate: _date,
        model: _model.text,
        engine: engine,
        plateNum: int.tryParse(_plate.text) ?? 0,
        gearType: _gear,
        bodySerialNum: int.tryParse(_bodySerial.text) ?? 0,
        length: int.tryParse(_length.text) ?? 0,
        width: int.tryParse(_width.text) ?? 0,
        color: _color.text,
        chairNum: int.tryParse(_chairs.text) ?? 0,
        isFurnitureLeather: _leather,
      );
      if (args is (TabKind, int)) {
        app.updateCar(args.$2, v);
      } else {
        app.addCar(v);
      }
    } else if (_kind == TabKind.trucks) {
      final v = Truck.full(
        manufactureCompany: _company.text,
        manufactureDate: _date,
        model: _model.text,
        engine: engine,
        plateNum: int.tryParse(_plate.text) ?? 0,
        gearType: _gear,
        bodySerialNum: int.tryParse(_bodySerial.text) ?? 0,
        length: int.tryParse(_length.text) ?? 0,
        width: int.tryParse(_width.text) ?? 0,
        color: _color.text,
        freeWeight: double.tryParse(_freeWeight.text) ?? 0,
        fullWeight: double.tryParse(_fullWeight.text) ?? 0,
      );
      if (args is (TabKind, int)) {
        app.updateTruck(args.$2, v);
      } else {
        app.addTruck(v);
      }
    } else {
      final v = Motorcycle.full(
        manufactureCompany: _company.text,
        manufactureDate: _date,
        model: _model.text,
        engine: engine,
        plateNum: int.tryParse(_plate.text) ?? 0,
        gearType: _gear,
        bodySerialNum: int.tryParse(_bodySerial.text) ?? 0,
        tierDiameter: double.tryParse(_tier.text) ?? 0,
        length: double.tryParse(_motoLen.text) ?? 0,
      );
      if (args is (TabKind, int)) {
        app.updateMotorcycle(args.$2, v);
      } else {
        app.addMotorcycle(v);
      }
    }

    app.save();
    Navigator.pop(context);
  }

  Future<void> _insertAtIndex(AppState app) async {
    final controller = TextEditingController();
    final index = await showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Insert at index'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Index'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, int.tryParse(controller.text)),
            child: const Text('Insert'),
          ),
        ],
      ),
    );
    if (index == null) return;

    final engine = _buildEngine();

    switch (_kind) {
      case TabKind.cars:
        app.insertCar(
          index,
          Car.full(
            manufactureCompany: _company.text,
            manufactureDate: _date,
            model: _model.text,
            engine: engine,
            plateNum: int.tryParse(_plate.text) ?? 0,
            gearType: _gear,
            bodySerialNum: int.tryParse(_bodySerial.text) ?? 0,
            length: int.tryParse(_length.text) ?? 0,
            width: int.tryParse(_width.text) ?? 0,
            color: _color.text,
            chairNum: int.tryParse(_chairs.text) ?? 0,
            isFurnitureLeather: _leather,
          ),
        );
        break;
      case TabKind.motorcycles:
        app.insertMotorcycle(
          index,
          Motorcycle.full(
            manufactureCompany: _company.text,
            manufactureDate: _date,
            model: _model.text,
            engine: engine,
            plateNum: int.tryParse(_plate.text) ?? 0,
            gearType: _gear,
            bodySerialNum: int.tryParse(_bodySerial.text) ?? 0,
            tierDiameter: double.tryParse(_tier.text) ?? 0,
            length: double.tryParse(_motoLen.text) ?? 0,
          ),
        );
        break;
      case TabKind.trucks:
        app.insertTruck(
          index,
          Truck.full(
            manufactureCompany: _company.text,
            manufactureDate: _date,
            model: _model.text,
            engine: engine,
            plateNum: int.tryParse(_plate.text) ?? 0,
            gearType: _gear,
            bodySerialNum: int.tryParse(_bodySerial.text) ?? 0,
            length: int.tryParse(_length.text) ?? 0,
            width: int.tryParse(_width.text) ?? 0,
            color: _color.text,
            freeWeight: double.tryParse(_freeWeight.text) ?? 0,
            fullWeight: double.tryParse(_fullWeight.text) ?? 0,
          ),
        );
        break;
    }
    if (mounted) Navigator.pop(context);
  }

  // hydrate helpers
  void _hydrateCar(Car c) {
    _company.text = c.manufactureCompany;
    _model.text = c.model;
    _plate.text = c.plateNum.toString();
    _bodySerial.text = c.bodySerialNum.toString();
    _gear = c.gearType;
    _date = c.manufactureDate;
    _engCompany.text = c.engine.manufacture;
    _engModel.text = c.engine.model;
    _engCap.text = c.engine.capacity.toString();
    _engCyl.text = c.engine.cylinders.toString();
    _fuel = c.engine.fuelType;
    _length.text = c.length.toString();
    _width.text = c.width.toString();
    _color.text = c.color;
    _chairs.text = c.chairNum.toString();
    _leather = c.isFurnitureLeather;
    setState(() {});
  }

  void _hydrateTruck(Truck t) {
    _company.text = t.manufactureCompany;
    _model.text = t.model;
    _plate.text = t.plateNum.toString();
    _bodySerial.text = t.bodySerialNum.toString();
    _gear = t.gearType;
    _date = t.manufactureDate;
    _engCompany.text = t.engine.manufacture;
    _engModel.text = t.engine.model;
    _engCap.text = t.engine.capacity.toString();
    _engCyl.text = t.engine.cylinders.toString();
    _fuel = t.engine.fuelType;
    _length.text = t.length.toString();
    _width.text = t.width.toString();
    _color.text = t.color;
    _freeWeight.text = t.freeWeight.toString();
    _fullWeight.text = t.fullWeight.toString();
    setState(() {});
  }

  void _hydrateMoto(Motorcycle m) {
    _company.text = m.manufactureCompany;
    _model.text = m.model;
    _plate.text = m.plateNum.toString();
    _bodySerial.text = m.bodySerialNum.toString();
    _gear = m.gearType;
    _date = m.manufactureDate;
    _engCompany.text = m.engine.manufacture;
    _engModel.text = m.engine.model;
    _engCap.text = m.engine.capacity.toString();
    _engCyl.text = m.engine.cylinders.toString();
    _fuel = m.engine.fuelType;
    _tier.text = m.tierDiameter.toString();
    _motoLen.text = m.length.toString();
    setState(() {});
  }
}
