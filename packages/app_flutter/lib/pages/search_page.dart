import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domain/services/search_service.dart';
import 'package:intl/intl.dart';
import '../state/app_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _q = TextEditingController();
  final _plate = TextEditingController();
  DateTime? _date;
  static const _kAnimDuration = Duration(milliseconds: 380);

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final df = DateFormat('yyyy-MM-dd');

    final cars = _q.text.isEmpty
        ? <String>[]
        : SearchService.carsByCompany(app.cars, _q.text)
              .map(
                (c) =>
                    'Car ${c.manufactureCompany} ${c.model}  • Plate ${c.plateNum}',
              )
              .toList();

    final motos = _q.text.isEmpty
        ? <String>[]
        : SearchService.motorcyclesByCompany(app.motorcycles, _q.text)
              .map(
                (m) =>
                    'Moto ${m.manufactureCompany} ${m.model} • Plate ${m.plateNum}',
              )
              .toList();

    final trucks = _q.text.isEmpty
        ? <String>[]
        : SearchService.trucksByCompany(app.trucks, _q.text)
              .map(
                (t) =>
                    'Truck ${t.manufactureCompany} ${t.model} • Plate ${t.plateNum}',
              )
              .toList();

    final byPlate = (_plate.text.isEmpty)
        ? <String>[]
        : [
            ...SearchService.byPlate(
              app.cars,
              (e) => e.plateNum,
              int.tryParse(_plate.text) ?? -1,
            ).map((c) => 'Car ${c.model}'),
            ...SearchService.byPlate(
              app.motorcycles,
              (e) => e.plateNum,
              int.tryParse(_plate.text) ?? -1,
            ).map((m) => 'Moto ${m.model}'),
            ...SearchService.byPlate(
              app.trucks,
              (e) => e.plateNum,
              int.tryParse(_plate.text) ?? -1,
            ).map((t) => 'Truck ${t.model}'),
          ];

    final byDate = (_date == null)
        ? <String>[]
        : [
            ...SearchService.byDate(
              app.cars,
              (e) => e.manufactureDate,
              _date!,
            ).map((c) => 'Car ${c.model}'),
            ...SearchService.byDate(
              app.motorcycles,
              (e) => e.manufactureDate,
              _date!,
            ).map((m) => 'Moto ${m.model}'),
            ...SearchService.byDate(
              app.trucks,
              (e) => e.manufactureDate,
              _date!,
            ).map((t) => 'Truck ${t.model}'),
          ];

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: _kAnimDuration,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                color: const Color.fromRGBO(255, 255, 255, 0.92),
                elevation: 0,
                borderRadius: BorderRadius.circular(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      TextField(
                        controller: _q,
                        decoration: const InputDecoration(
                          labelText: 'Company name',
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _plate,
                        decoration: const InputDecoration(
                          labelText: 'Plate number',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        title: Text(
                          'Manufacture date: ${_date == null ? '—' : df.format(_date!)}',
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final d = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1970),
                            lastDate: DateTime(2100),
                            initialDate: _date ?? DateTime.now(),
                          );
                          if (d != null) setState(() => _date = d);
                        },
                      ),
                      const Divider(),
                      if (_q.text.isNotEmpty) ...[
                        Text(
                          'By Company:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        ...cars.map(Text.new),
                        ...motos.map(Text.new),
                        ...trucks.map(Text.new),
                        const SizedBox(height: 12),
                      ],
                      if (_plate.text.isNotEmpty) ...[
                        Text(
                          'By Plate:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        ...byPlate.map(Text.new),
                        const SizedBox(height: 12),
                      ],
                      if (_date != null) ...[
                        Text(
                          'By Date:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        ...byDate.map(Text.new),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
