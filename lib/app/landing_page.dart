import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:time_tracker/app/home_page.dart';
import '../services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future _checkCurrentUser() async {
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null)
      return SignInPage(
        auth: widget.auth,
        onSignIn: _updateUser,
      );
    else
      return HomePage(
        auth: widget.auth,
        onSignout: () => _updateUser(null),
      );
  }
}
