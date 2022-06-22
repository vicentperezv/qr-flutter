import 'package:flutter/material.dart';
import 'package:qr_reader/models/models.dart';
import 'package:qr_reader/screens/screens.dart';

class AppRoutes{

  static const initialRoute = 'home';

  static final menuOption =<MenuOption>[
    MenuOption(route: 'home', name: 'Home', screen: const HomeScreen()),
    MenuOption(route: 'map', name: 'Map', screen: const MapScreen()),
  ];

  static Map<String,Widget Function(BuildContext)> getAppRoutes() {
    Map<String,Widget Function(BuildContext)> appRoutes = {};

    for(final option in menuOption) {
      appRoutes.addAll({option.route: ( BuildContext context ) => option.screen});
    }
    return appRoutes;
  }
}