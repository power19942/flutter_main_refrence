import 'package:flutter/material.dart';
import '../services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.auth});

  final AuthBase auth;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
              onPressed: _signout,
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))
        ],
      ),
    );
  }

  Future<void> _signout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
