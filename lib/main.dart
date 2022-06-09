import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:gezgor/service/provider/oymodel.dart';
import 'package:gezgor/service/provider/oytoplammodel.dart';
import 'package:gezgor/service/provider/starmodel.dart';
import 'package:gezgor/views/auth/login/loginpage.dart';
import 'package:gezgor/views/homepage/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

Future<bool> control() async {
  if (FirebaseAuth.instance.currentUser == null) {
    return false;
  } else {
    return true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => StarModel()),
        ChangeNotifierProvider(create: (_) => OyToplamModel()),
        ChangeNotifierProvider(create: (_) => OyModel()),
      ],
      child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder<bool>(
            future: control(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool izin = snapshot.data!;
                return izin ? const HomePage() : const LoginPage();
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
