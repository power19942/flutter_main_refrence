import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

import 'email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  final AuthBase auth;

  EmailSignInPage({@required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Time Tracker'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            child: EmailSignInForm(
              auth: auth,
            ),
          ),
        ),
      ),
    );
  }
}
