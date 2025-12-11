import 'package:financial_tracker/components/my_text_field.dart';
import 'package:financial_tracker/services/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  final void Function()? onSignUpClicked;
  const LoginPage({super.key, required this.onSignUpClicked});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final authNotifier = ref.read(authProvider.notifier);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),
            // Title
            Text(
              'Welcome',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 40),

            // Form Fields
            MyTextField(
              label: 'Email',
              hint: 'example@example.com',
              controller: emailController,
              // Note: Label is included in MyTextField, but we omit it here
              // to match the login page design where the label is missing.
            ),
            const SizedBox(height: 20),
            MyTextField(
              label: 'Password',
              hint: '**********',
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 30),

            // Log In Button (Secondary/Golden Brown)
            ElevatedButton(
              onPressed: () async {
                try {
                  await authNotifier.signIn(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                } catch (e) {
                  // Handle sign-up error (e.g., show a snackbar)
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Log in failed: $e',
                          style: TextStyle(
                            color: theme.colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary, // Golden Brown
                foregroundColor: Colors.white,
              ),
              child: const Text('Log In'),
            ),

            // Forgot Password
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ),

            const SizedBox(height: 30),

            // Social Logins
            Text(
              'or sign up with',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      try {
                        await authNotifier.signInWithGoogle();
                      } catch (e) {
                        // Handle sign-in with google error (e.g., show a snackbar)
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Sign in with google failed: $e',
                                style: TextStyle(
                                  color: theme.colorScheme.inversePrimary,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    icon: Icon(
                      Icons.g_mobiledata_sharp,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            // Login Link (in case they want to sign up)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                TextButton(
                  onPressed: onSignUpClicked,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color:
                          theme.colorScheme.inversePrimary, // Black/Dark Text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
