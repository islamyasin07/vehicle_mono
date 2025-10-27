import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/edit_vehicle_page.dart';
import '../pages/search_page.dart';

class AppRoutes {
  static const home = '/';
  static const edit = '/edit';
  static const search = '/search';

  static Map<String, WidgetBuilder> map() => {
        home: (_) => const HomePage(),
        edit: (_) => const EditVehiclePage(),
        search: (_) => const SearchPage(),
      };
}
