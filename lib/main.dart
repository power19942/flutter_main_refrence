import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/landing_page.dart';
import 'package:time_tracker/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      builder: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );
  }
}
