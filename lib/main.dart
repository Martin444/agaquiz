import 'package:agaquiz/features/Login/controllers/login_controller.dart';
import 'package:agaquiz/features/Login/presentation/page/login_page.dart';
import 'package:agaquiz/features/admin/controllers/admin_controller.dart';
import 'package:agaquiz/features/admin/presentation/admin_page.dart';
import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyBgD94GggqsaXFdlJiyihSjzuQ7-cJWS8k",
            authDomain: "pregunta2-fc6ff.firebaseapp.com",
            storageBucket: "pregunta2-fc6ff.appspot.com",
            appId: "1:732163124779:web:c39622e4f219d7a86dc46e",
            messagingSenderId: "732163124779",
            projectId: "pregunta2-fc6ff",
          ),
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == 'not-initialized') {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyBgD94GggqsaXFdlJiyihSjzuQ7-cJWS8k",
            authDomain: "pregunta2-fc6ff.firebaseapp.com",
            storageBucket: "pregunta2-fc6ff.appspot.com",
            appId: "1:732163124779:web:c39622e4f219d7a86dc46e",
            messagingSenderId: "732163124779",
            projectId: "pregunta2-fc6ff",
          ),
        );
        print(e.message);
      }
    }
    runApp(const MyApp());
  } catch (e) {
    print('Error firebase initialize');
    var firebaseError = (e as FirebaseException);
    print(firebaseError.code);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerDelegate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '/': (context, state, data) => const LoginPage(),
          '/admin': (context, state, data) => const AdminPage(),
        },
      ).call,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => AdminController()),
      ],
      child: MaterialApp.router(
        title: 'AgaQuiz',
        debugShowCheckedModeBanner: false,
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
      ),
    );
  }
}
