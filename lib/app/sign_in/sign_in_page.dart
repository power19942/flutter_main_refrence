import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/common_widgets/platform_exception_alert_dialog.dart';
import '../../services/auth.dart';
import './email_sign_in_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in faild',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context);
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context);
      await auth.signInWithGoogle();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context);
      await auth.signInWithFacebook();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => EmailSignInPage()));
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
          SizedBox(height: 50, child: _buildHeader()),
          SizedBox(
            height: 10,
          ),
          SignInButton(
            text: 'Sign in with Google',
            color: Colors.white,
            onPressed: () => _isLoading ? null : _signInWithGoogle(context),
          ),
          SizedBox(
            height: 10,
          ),
          SignInButton(
              text: 'Sign in with Facebook',
              color: Color(0xff334d92),
              textColor: Colors.white,
              onPressed: () =>
                  _isLoading ? null : _signInWithFacebook(context)),
          SizedBox(
            height: 10,
          ),
          SignInButton(
            text: 'Sign in with Email',
            color: Colors.teal[700],
            textColor: Colors.white,
            onPressed: () => _isLoading ? null : _signInWithEmail(context),
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
            onPressed: _isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }
}
