import 'package:agaquiz/features/Login/presentation/page/login_page.dart';
import 'package:agaquiz/routes/my_routes_path.dart';
import 'package:flutter/material.dart';

class MyRouterDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  String _currentPage = '/';
  final int _currentDetailId = 0;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  MyRoutePath get currentConfiguration {
    if (_currentPage == '/') {
      return MyRoutePath.home();
    } else if (_currentPage == '/detalle' && _currentDetailId != 1) {
      return MyRoutePath.details({});
    } else {
      return MyRoutePath.unknown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage(
          key: ValueKey('HomePage'),
          child: LoginPage(),
        ),
        if (_currentPage == '/detalle')
          const MaterialPage(
            key: ValueKey('DetailPage'),
            child: Text('detail'),
          ),
      ],
      onPopPage: (route, result) {
        // Implementa tu lógica aquí
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MyRoutePath path) async {
    _currentPage = path.route;
    notifyListeners();
  }
}
