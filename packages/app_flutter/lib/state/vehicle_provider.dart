import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/di.dart' as di;
import 'app_state.dart';

class VehicleProvider extends StatelessWidget {
  final Widget child;
  const VehicleProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: di.Locator.makeRepo(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Material(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return ChangeNotifierProvider(
          create: (_) => AppState(snap.data!),
          child: child,
        );
      },
    );
  }
}
