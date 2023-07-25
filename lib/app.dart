import 'package:flutter/material.dart';
import 'package:flutter_dynamic_forms/routing_table.dart';
import 'package:flutter_dynamic_forms/theme.dart';
import 'package:form_repository/form_repository.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GoRouter _routerConfig;
  late final _formRepository = FormRepository();

  @override
  Widget build(BuildContext context) {
    _routerConfig = AppRouter.buildRoutingTable(
      formRepository: _formRepository,
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _routerConfig.routeInformationProvider,
      routeInformationParser: _routerConfig.routeInformationParser,
      routerDelegate: _routerConfig.routerDelegate,
      theme: ApplicationTheme.light,
      darkTheme: ApplicationTheme.dark,
      themeMode: ThemeMode.light,
    );
  }
}
