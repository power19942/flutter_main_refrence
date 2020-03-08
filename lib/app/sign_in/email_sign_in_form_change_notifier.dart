import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_change_model.dart';
import 'package:time_tracker/common_widgets/form_submit_buttion.dart';
import 'package:time_tracker/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';

import 'email_sign_in_model.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  EmailSignInFormChangeNotifier({this.model});

  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (context) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, model, _) =>
            EmailSignInFormChangeNotifier(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotifierState createState() =>
      _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState
    extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  Future<void> _submit() async {
    try {
      await model.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in faild',
        exception: e,
      ).show(context);
    }
  }

  void _toggleFormType() {
    widget.model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
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
        onPressed: model.canSubmit ? _submit : null,
        text: model.primaryButtonText,
      ),
      SizedBox(
        height: 8,
      ),
      FlatButton(
          onPressed: !model.isLoading ? _toggleFormType : null,
          child: Text(model.secondaryButtonText))
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
    return TextField(
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'email@provider.com',
          errorText: model.emailErrorText),
      enabled: model.isLoading == false,
      autocorrect: false,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: model.updateEmail,
      controller: _emailController,
    );
  }

  _buildPassword() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      obscureText: true,
      onChanged: model.updatePassword,
    );
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }
}
