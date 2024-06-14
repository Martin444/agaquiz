class MyRoutePath {
  final String route;
  final Object? arguments;

  MyRoutePath.home()
      : route = '/',
        arguments = null;
  MyRoutePath.details(this.arguments) : route = '/detalle';
  MyRoutePath.unknown()
      : route = '/404',
        arguments = null;

  bool get isHomePage => route == '/';
  bool get isDetailsPage => route == '/details';
  bool get isUnknown => route == '/404';
}
