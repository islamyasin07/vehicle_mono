import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../widgets/vehicle_card.dart';
import '../core/routes.dart';

enum TabKind { cars, motorcycles, trucks }

class ListTab extends StatelessWidget {
  final TabKind kind;
  const ListTab({super.key, required this.kind});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();

    switch (kind) {
      case TabKind.cars:
        return _VehicleList(
          isEmpty: app.cars.isEmpty,
          emptyText: 'No cars yet. Tap + to add.',
          length: app.cars.length,
          itemBuilder: (i) {
            final c = app.cars[i];
            return _animatedItem(
              index: i,
              child: VehicleCard(
                title: '${c.manufactureCompany} ${c.model}',
                subtitle: 'Plate ${c.plateNum} • Body ${c.bodySerialNum}',
                type: VehicleType.car,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.edit,
                  arguments: (kind, i),
                ),
                onDismissed: (_) {
                  context.read<AppState>().deleteCarAt(i);
                  context.read<AppState>().save();
                },
              ),
            );
          },
        );

      case TabKind.motorcycles:
        return _VehicleList(
          isEmpty: app.motorcycles.isEmpty,
          emptyText: 'No motorcycles yet. Tap + to add.',
          length: app.motorcycles.length,
          itemBuilder: (i) {
            final m = app.motorcycles[i];
            return _animatedItem(
              index: i,
              child: VehicleCard(
                title: '${m.manufactureCompany} ${m.model}',
                subtitle: 'Plate ${m.plateNum} • Body ${m.bodySerialNum}',
                type: VehicleType.motorcycle,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.edit,
                  arguments: (kind, i),
                ),
                onDismissed: (_) {
                  context.read<AppState>().deleteMotorcycleAt(i);
                  context.read<AppState>().save();
                },
              ),
            );
          },
        );

      case TabKind.trucks:
        return _VehicleList(
          isEmpty: app.trucks.isEmpty,
          emptyText: 'No trucks yet. Tap + to add.',
          length: app.trucks.length,
          itemBuilder: (i) {
            final t = app.trucks[i];
            return _animatedItem(
              index: i,
              child: VehicleCard(
                title: '${t.manufactureCompany} ${t.model}',
                subtitle: 'Plate ${t.plateNum} • Body ${t.bodySerialNum}',
                type: VehicleType.truck,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.edit,
                  arguments: (kind, i),
                ),
                onDismissed: (_) {
                  context.read<AppState>().deleteTruckAt(i);
                  context.read<AppState>().save();
                },
              ),
            );
          },
        );
    }
  }
}

class _VehicleList extends StatelessWidget {
  final bool isEmpty;
  final String emptyText;
  final int length;
  final Widget Function(int index) itemBuilder;

  const _VehicleList({
    required this.isEmpty,
    required this.emptyText,
    required this.length,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 420),
            opacity: 0.9,
            child: Text(emptyText, textAlign: TextAlign.center),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 88),
      physics: const BouncingScrollPhysics(),
      itemCount: length,
      itemBuilder: (_, i) => itemBuilder(i),
    );
  }
}

Widget _animatedItem({required int index, required Widget child}) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: 1),
    duration: const Duration(milliseconds: 380),
    curve: Curves.easeOut,
    builder: (context, t, _) => Opacity(
      opacity: t,
      child: Transform.translate(offset: Offset(0, (1 - t) * 12), child: child),
    ),
  );
}
