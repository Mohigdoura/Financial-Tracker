import 'dart:async';
import 'dart:developer';
import 'package:financial_tracker/services/auth/auth_services.dart';
import 'package:financial_tracker/services/auth/auth_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authServiceProvider = Provider((ref) => AuthService());

final authProvider = StateNotifierProvider<AuthNotifier, AuthStates>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthNotifier(authService);
});

class AuthNotifier extends StateNotifier<AuthStates> {
  final AuthService authService;
  StreamSubscription<AuthState?>? _authStateSubscription;

  AuthNotifier(this.authService) : super(AuthStates.loading()) {
    init();
  }
  User? get currentUser => authService.currentUser;

  Future<void> init() async {
    state = AuthStates.loading();

    final user = authService.currentUser;

    if (user != null) {
      log("User already signed in: ${user.id}");
      state = AuthStates.loggedIn();
    } else {
      log("No user signed in");
      state = AuthStates.loggedOut();
    }

    // Start listening afterward to capture any future changes
    _authStateSubscription = authService.supabase.auth.onAuthStateChange.listen(
      (change) {
        try {
          log(
            'Auth state changed: currentUser=${authService.currentUser?.id ?? "null"}',
          );

          if (authService.currentUser != null) {
            state = AuthStates.loggedIn();
          } else {
            state = AuthStates.loggedOut();
          }
        } catch (e) {
          log('Error handling auth state change: $e');
          state = AuthStates.error('Auth change handling error: $e');
        }
      },
      onError: (error) {
        log('Auth state listener error: $error');
        state = AuthStates.error("Auth error: $error");
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }

  Future<void> signIn(String email, String password) async {
    try {
      // Show loading state immediately
      state = AuthStates.loading();
      log('Starting sign in process...');

      await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verify user is actually signed in
      if (authService.currentUser != null) {
        state = AuthStates.loggedIn();
        log('Sign in successful');
      } else {
        throw Exception('Sign in failed - no user returned');
      }
    } catch (e) {
      log('Sign in failed: $e');
      state = AuthStates.loggedOut();
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      // Show loading state immediately
      state = AuthStates.loading();
      log('Starting sign up process...');

      await authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verify user is actually signed in
      if (authService.currentUser != null) {
        state = AuthStates.loggedIn();
        log('Sign up successful');
      } else {
        throw Exception('Sign up failed - no user returned');
      }
    } catch (e) {
      log('Sign up failed: $e');
      state = AuthStates.loggedOut();
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Show loading state immediately
      state = AuthStates.loading();
      log('Starting sign in process...');

      await authService.googleSignIn();

      // Verify user is actually signed in
      if (authService.currentUser != null) {
        state = AuthStates.loggedIn();
        log('Sign in successful');
      } else {
        throw Exception('Sign in failed - no user returned');
      }
    } catch (e) {
      log('Sign in failed: $e');
      state = AuthStates.loggedOut();
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      // Show loading state during sign out
      state = AuthStates.loading();
      log('Starting sign out process...');

      // Then sign out
      await authService.signOut();

      state = AuthStates.loggedOut();
      log('User signed out successfully');
    } catch (e) {
      log('Error during sign out: $e');
      // Still set to logged out even if there's an error
      state = AuthStates.loggedOut();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await authService.resetPassword(email);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
