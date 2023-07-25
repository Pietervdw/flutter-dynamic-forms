import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home/home.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter buildRoutingTable() {
    return GoRouter(
      debugLogDiagnostics: false,
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          name: "home",
          path: "/",
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage(child: HomeScreen(),);
          },
        ),
      ],
    );
  }
}
