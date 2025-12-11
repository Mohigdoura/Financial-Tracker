import 'package:financial_tracker/Pages/auth/auth_gate.dart';
import 'package:financial_tracker/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

const supabaseUrl = 'https://clkdlscmzpixqjqniouz.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsa2Rsc2NtenBpeHFqcW5pb3V6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NzIxNDksImV4cCI6MjA4MTA0ODE0OX0.HEn-WoNgKx2eCee9mIGasyICcLEysTY3s5fOXhGJ2dM';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: AuthGate(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
