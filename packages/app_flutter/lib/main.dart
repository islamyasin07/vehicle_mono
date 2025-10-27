import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'core/routes.dart';
import 'state/vehicle_provider.dart';
import 'state/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VehicleApp());
}

class VehicleApp extends StatelessWidget {
  const VehicleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: Builder(
        builder: (context) {
          final theme = context.watch<ThemeController>();
          return VehicleProvider(
            child: MaterialApp(
              title: 'Vehicle Manager',
              debugShowCheckedModeBanner: false,
              theme: buildLightTheme(),
              darkTheme: buildDarkTheme(),
              themeMode: theme.mode,
              routes: AppRoutes.map(),
            ),
          );
        },
      ),
    );
  }
}
