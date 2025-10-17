import 'package:agaquiz/routes/my_routes_path.dart';
import 'package:flutter/material.dart';

class MyRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    // Maneja '/'
    if (uri.pathSegments.isEmpty) {
      return MyRoutePath.home();
    }

    // Maneja '/detalle/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == 'detalle') {
        var id = uri.pathSegments[1];
        return MyRoutePath.details(id);
      }
    }

    // Maneja casos desconocidos
    return MyRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(MyRoutePath path) {
    if (path.isUnknown) {
      return const RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return const RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return const RouteInformation(location: '/detalle/');
    }
    return const RouteInformation(location: '/404');
    // return null;
  }
}
