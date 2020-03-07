import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_form_bloc_based.dart';
import 'package:time_tracker/services/auth.dart';

import 'email_sign_in_form_stateful.dart';

class EmailSignInPage extends StatelessWidget {
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
            child: EmailSignInFormBlocBased.create(context),
          ),
        ),
      ),
    );
  }
}
