import 'package:firebase/pages/home_page.dart';
import 'package:firebase/pages/splash_page.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCR9RbRr9E0hr_HJhLSVa9I3PO98UDC6JY",
            authDomain: "fir-demo-22ede.firebaseapp.com",
            databaseURL: "https://fir-demo-22ede-default-rtdb.firebaseio.com",
            projectId: "fir-demo-22ede",
            storageBucket: "fir-demo-22ede.appspot.com",
            messagingSenderId: "1007714631616",
            appId: "1:1007714631616:web:4424f7138c866db73c9225"));
  }else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyAvS6ZEBlc7VSGHpzO6mvbHyRrHMu8zjXc',
          appId: '1:1007714631616:android:831fb1be49196ee03c9225',
          messagingSenderId: 'messagingSenderId',
          projectId: 'fir-demo-22ede',
          storageBucket: 'fir-demo-22ede.appspot.com',
        ));
  }

    runApp(const MyApp());
  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
