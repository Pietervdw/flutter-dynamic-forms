import 'package:flutter/material.dart';
import 'package:form_repository/form_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:home/home.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter buildRoutingTable({
    required FormRepository formRepository,
  }) {
    return GoRouter(
      debugLogDiagnostics: false,
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          name: "home",
          path: "/",
          pageBuilder: (BuildContext context, GoRouterState state) {
            return  MaterialPage(
              child: HomeScreen(
                formRepository: formRepository,
              ),
            );
          },
        ),
      ],
    );
  }
}
