import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/common_screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme.dart';
import 'screens/widget/studentbottomNavBar.dart';

import 'screens/student/student_dashboard.dart';
import 'screens/trainer/trainer_dashboard.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hertzsoft's Educare",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: AnimatedSplashScreen(
        // nextScreen: const AuthCheck(),
        nextScreen: CustomBottomNavBar(currentIndex: currentIndex, onTap: onTap),
      ),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Check if  user is logged in (for token, userIO,etc.)
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final userToken = prefs.getString('userToken');
    final userType = prefs.getString('userType'); // student or  trainer

    // small delay to wait for details to load
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    if (isLoggedIn  && userToken !=  null && userToken.isNotEmpty) {
    //   user is logged in - check user type and navigate accordingly
      if (userType == 'student') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (Context) => const StudentDashboard()),
        );
      }
      else if (userType == 'trainer') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (Context) => const TrainerDashboard()),
        );
      }
      else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
    else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Show a loading indicator while checking auth status
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
