import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:time_tracker/common_widgets/platform_alert_dialog.dart';
import '../services/auth_provider.dart';
class HomePage extends StatelessWidget {

  Future<void> _signout(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final result = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout ?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (result) {
      _signout(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
              onPressed: () => _confirmSignOut(context),
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
