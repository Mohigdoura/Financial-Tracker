import 'package:flutter/material.dart';

// --- CUSTOM COLORS AND THEME ---
// Using shades that better match the provided images for a richer look.
const Color _kDarkGreen = Color(
  0xFF38761D,
); // Primary: Text field fill and sign up button
const Color _kGoldenBrown = Color(0xFFC9A76E); // Secondary: Login/Action button

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: _kDarkGreen, // Used for primary accents and input fills
    secondary: _kGoldenBrown, // Used for secondary actions (Log In button)
    inversePrimary: Colors.black, // Used for main text (e.g., 'Create Account')
    surface: Colors.white, // Background color
  ),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto', // A common, clean font
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50), // Full width button height
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: _kDarkGreen, // Used for primary accents and input fills
    secondary: _kGoldenBrown, // Used for secondary actions (Log In button)
    inversePrimary: Colors.black, // Used for main text (e.g., 'Create Account')
    surface: Colors.white, // Background color
  ),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto', // A common, clean font
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50), // Full width button height
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ),
);
