import 'package:financial_tracker/components/my_text_field.dart';
import 'package:financial_tracker/services/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerWidget {
  final void Function()? onLoginClicked;
  const SignUpPage({super.key, required this.onLoginClicked});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final authNotifier = ref.read(authProvider.notifier);

    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),
            // Title
            Text(
              'Create Account',
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
              label: 'Full Name',
              hint: 'example example',
              controller: fullNameController,
            ),
            const SizedBox(height: 20),
            MyTextField(
              label: 'Email',
              hint: 'example@example.com',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 20),
            MyTextField(
              label: 'Password',
              hint: '********',
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            MyTextField(
              label: 'Confirm Password',
              hint: '********',
              controller: confirmPasswordController,
              isPassword: true,
            ),

            const SizedBox(height: 30),

            // Terms and Privacy Policy
            Text(
              'By continuing, you agree to \nTerms of Use and Privacy Policy.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.inversePrimary,
                // Bold and colored text for the links to match the image
              ),
            ),
            const SizedBox(height: 15),

            // Sign Up Button (Secondary/Golden Brown)
            ElevatedButton(
              onPressed: () async {
                try {
                  await authNotifier.signUp(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                } catch (e) {
                  // Handle sign-up error (e.g., show a snackbar)
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Sign up failed: $e',
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
              child: const Text('Sign Up'),
            ),

            const SizedBox(height: 20),

            // Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                TextButton(
                  onPressed: onLoginClicked,
                  child: Text(
                    'Log In',
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
