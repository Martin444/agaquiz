import 'package:agaquiz/core/config.dart';
import 'package:agaquiz/features/Login/presentation/page/login_page.dart';
import 'package:agaquiz/features/admin/presentation/admin_page.dart';
import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      if (Firebase.apps.isEmpty) {
        print("AIzaSyBgD94GggqsaXFdlJiyihSjzuQ7-cJWS8k");
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: FIRE_API_KEY,
            authDomain: FIRE_AUTH_DOMAIN,
            storageBucket: FIRE_STORAGE_BUCKET,
            appId: FIRE_APP_ID,
            messagingSenderId: FIRE_MESSAGING_SENDER_ID,
            projectId: FIRE_PROYECT_ID,
          ),
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == 'not-initialized') {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: FIRE_API_KEY,
            authDomain: FIRE_AUTH_DOMAIN,
            storageBucket: FIRE_STORAGE_BUCKET,
            appId: FIRE_APP_ID,
            messagingSenderId: FIRE_MESSAGING_SENDER_ID,
            projectId: FIRE_PROYECT_ID,
          ),
        );
      }
    }
    runApp(const MyApp());
  } catch (e) {
    var firebaseError = (e as FirebaseException);
    print(e);
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

    return ProviderScope(
      child: MaterialApp.router(
        title: 'AgaQuiz',
        debugShowCheckedModeBanner: false,
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
      ),
    );
  }
}
