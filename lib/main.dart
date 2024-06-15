import 'package:agaquiz/features/Login/controllers/login_controller.dart';
import 'package:agaquiz/routes/routes_info.dart';
import 'package:agaquiz/routes/routes_information_parser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController())
      ],
      child: MaterialApp.router(
        title: 'AgaQuiz',
        debugShowCheckedModeBanner: false,
        routeInformationParser: MyRouteInformationParser(),
        routerDelegate: MyRouterDelegate(),
      ),
    );
  }
}
