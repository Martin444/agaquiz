import 'package:agaquiz/routes/my_routes_path.dart';
import 'package:agaquiz/routes/routes_info.dart';

class RoutesController {
  final MyRouterDelegate routerDelegate;
  const RoutesController({
    required this.routerDelegate,
  });

  void gotoPage() {
    routerDelegate.setNewRoutePath(MyRoutePath.details({}));
  }
}
