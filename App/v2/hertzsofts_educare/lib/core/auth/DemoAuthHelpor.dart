import 'package:shared_preferences/shared_preferences.dart';

/// Demo Authentication Helper
/// This class provides temporary demo login functionality for testing purposes
///
/// Demo Credentials:
/// Student: student@demo.com / student123
/// Trainer: trainer@demo.com / trainer123
class DemoAuthHelper {
  // Demo credentials
  static const String demoStudentEmail = 'student@demo.com';
  static const String demoStudentPassword = 'student123';
  static const String demoTrainerEmail = 'trainer@demo.com';
  static const String demoTrainerPassword = 'trainer123';

  /// Validates demo credentials and returns user type if valid
  /// Returns null if credentials are invalid
  static String? validateDemoCredentials(String email, String password) {
    if (email.toLowerCase() == demoStudentEmail && password == demoStudentPassword) {
      return 'student';
    } else if (email.toLowerCase() == demoTrainerEmail && password == demoTrainerPassword) {
      return 'trainer';
    }
    return null;
  }

  /// Performs demo login and saves auth data to SharedPreferences
  /// Returns true if login successful, false otherwise
  static Future<bool> performDemoLogin(String email, String password) async {
    final userType = validateDemoCredentials(email, password);

    if (userType == null) {
      return false;
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      // Save authentication data
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userToken', 'demo_token_${DateTime.now().millisecondsSinceEpoch}');
      await prefs.setString('userType', userType);
      await prefs.setString('userEmail', email);

      return true;
    } catch (e) {
      print('Error saving demo login data: $e');
      return false;
    }
  }

  /// Logs out the user by clearing SharedPreferences
  static Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print('Error clearing login data: $e');
    }
  }

  /// Check if user is currently logged in
  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('isLoggedIn') ?? false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  /// Get current user type
  static Future<String?> getUserType() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('userType');
    } catch (e) {
      print('Error getting user type: $e');
      return null;
    }
  }
}