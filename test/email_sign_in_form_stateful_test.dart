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
  Future<void> pumpEmailSignInForm(WidgetTester tester,
      {VoidCallback onSignin}) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: Scaffold(
          body: EmailSignInFormStateful(
            onSignIn: onSignin,
          ),
        ),
      ),
    ));
  }

  group('sign in', () {
    testWidgets(
        'when user dosent enter the email and password'
        'and user type on the sign in button'
        'then signInWithEmailAndPassowrd is not called',
        (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignin: () => signedIn = true);
      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);
      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
      expect(signedIn, false);
    });

    testWidgets(
        'when user enter the email and password'
        'and user type on the sign in button'
        'then signInWithEmailAndPassowrd is called',
        (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);
      const email = 'email@email.com';
      const password = 'password';

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      await tester.pump();

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);
      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
    });
  });

  group('register', () {
    testWidgets(
        'when user tap on secondary button'
        'then form toggles to registration mode', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);
      await tester.pump();
      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);
    });

    testWidgets('register called .......', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);
      const email = 'email@email.com';
      const password = 'password';

      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);
      await tester.pump();

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      await tester.pump();

      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);
      await tester.tap(createAccountButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(email, password))
          .called(0);
    });
  });
}
