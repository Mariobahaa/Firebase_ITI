import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseiti/screens/Img/Img.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _fbApp,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              appBar: AppBar(),
              body: Img(),
            ),
            debugShowCheckedModeBanner: false,
          );
        } else {
          return MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              appBar: AppBar(),
              body: Container(
                child: Center(
                  child: Text("No data to show"),
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {

// }
