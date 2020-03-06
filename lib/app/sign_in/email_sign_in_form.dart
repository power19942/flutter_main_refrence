import 'dart:io';

import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/vakidators.dart';
import 'package:time_tracker/common_widgets/form_submit_buttion.dart';
import 'package:time_tracker/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_provider.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = AuthProvider.of(context);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      PlatformAlertDialog(
        title: 'Sign in faild',
        content: e.toString(),
        defaultActionText: 'Ok',
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Segister'
        : 'Have an account? Sign in';
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmail(),
      SizedBox(
        height: 8,
      ),
      _buildPassword(),
      SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        onPressed: submitEnabled ? _submit : null,
        text: primaryText,
      ),
      SizedBox(
        height: 8,
      ),
      FlatButton(
          onPressed: !_isLoading ? _toggleFormType : null,
          child: Text(secondaryText))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  _buildEmail() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'email@provider.com',
          errorText: showErrorText ? widget.invalidEmailErrorText : null),
      enabled: _isLoading == false,
      autocorrect: false,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
      controller: _emailController,
    );
  }

  _buildPassword() {
    bool sowErrorText = _submitted && !widget.emailValidator.isValid(_password);
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: sowErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      obscureText: true,
      onChanged: (password) => _updateState(),
    );
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  _updateState() {
    setState(() {});
  }
}
