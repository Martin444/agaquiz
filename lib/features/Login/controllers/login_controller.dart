import 'package:agaquiz/features/Login/presentation/state/login_state_abs.dart';
import 'package:agaquiz/routes/routes_controller.dart';
import 'package:agaquiz/routes/routes_info.dart';

class LoginController extends LoginStateManage {
  late final MyRouterDelegate routeDelegate;
  late final RoutesController routeController;

  LoginController() {
    routeDelegate = MyRouterDelegate();
    routeController = RoutesController(routerDelegate: routeDelegate);
  }
  @override
  void postNameUser() {
    print(nameController.text);
    routeController.gotoPage();
  }
}
