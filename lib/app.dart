import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_forms/routing_table.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GoRouter _routerConfig;

  @override
  Widget build(BuildContext context) {
    _routerConfig = AppRouter.buildRoutingTable();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _routerConfig.routeInformationProvider,
      routeInformationParser: _routerConfig.routeInformationParser,
      routerDelegate: _routerConfig.routerDelegate,
      theme: FlexThemeData.light(scheme: FlexScheme.blueWhale),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.blueWhale),
      themeMode: ThemeMode.system,
    );
  }
}
