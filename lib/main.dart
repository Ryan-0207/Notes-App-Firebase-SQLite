import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity/connectivity.dart';
import 'package:notes_app/Homepageoffline.dart';

import 'package:notes_app/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Widget firstwidget;
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
    firstwidget = Loginpage();
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
    firstwidget = Loginpage();
  } else {
    firstwidget = HomePage2();
  }

  runApp(MaterialApp(
    title: '',
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      primaryColor: Colors.white,
    ),
    home: firstwidget,
  ));
}
