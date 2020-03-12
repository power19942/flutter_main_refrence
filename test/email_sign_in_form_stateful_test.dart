import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_form_stateful.dart';
import 'package:time_tracker/services/auth.dart';

class MockAuth extends Mock implements AuthBase {}

main() {
  MockAuth mockAuth;
  setUp(() {
    mockAuth = MockAuth();
  });
  Future<void> pumpEmailSignInForm(WidgetTester tester) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: Scaffold(
          body: EmailSignInFormStateful(),
        ),
      ),
    ));
  }

  testWidgets(
      'when user dosent enter the email and password'
      'and user type on the sign in button'
      'then signInWithEmailAndPassowrd is not called',
      (WidgetTester tester) async {
    await pumpEmailSignInForm(tester);
    final SignInButton = find.text('Sign in');
    await tester.tap(SignInButton);
    verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
  });
}
