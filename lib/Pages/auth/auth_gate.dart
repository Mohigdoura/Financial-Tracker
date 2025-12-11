import 'package:financial_tracker/Pages/auth/login_page.dart';
import 'package:financial_tracker/Pages/auth/sign_up_page.dart';
import 'package:financial_tracker/Pages/my_home_page.dart';
import 'package:financial_tracker/services/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    void togglePage() {
      setState(() {
        isLoginPage = !isLoginPage;
      });
    }

    if (authState.isAuthenticated) {
      // User is authenticated, navigate to home page
      return MyHomePage();
    } else if (authState.isLoading) {
      // Authentication state is loading
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      // User is not authenticated, show login or sign-up page
      return isLoginPage
          ? LoginPage(onSignUpClicked: togglePage)
          : SignUpPage(onLoginClicked: togglePage);
    }
  }
}
