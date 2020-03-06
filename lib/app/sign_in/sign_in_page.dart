import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import '../../services/auth.dart';
import './email_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  final AuthBase auth;

  SignInPage({@required this.auth});

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => EmailSignInPage(
              auth: auth,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Time Tracker'),
        elevation: 2,
      ),
      body: _buildContent(context),
    );
  }

  _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          SignInButton(
            text: 'Sign in with Google',
            color: Colors.white,
            onPressed: _signInWithGoogle,
          ),
          SizedBox(
            height: 10,
          ),
          SignInButton(
              text: 'Sign in with Facebook',
              color: Color(0xff334d92),
              textColor: Colors.white,
              onPressed: _signInWithFacebook),
          SizedBox(
            height: 10,
          ),
          SignInButton(
            text: 'Sign in with Email',
            color: Colors.teal[700],
            textColor: Colors.white,
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'or',
            style: TextStyle(fontSize: 14, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          SignInButton(
            text: 'Go anonymous',
            color: Colors.lime[600],
            onPressed: _signInAnonymously,
          ),
        ],
      ),
    );
  }
}
