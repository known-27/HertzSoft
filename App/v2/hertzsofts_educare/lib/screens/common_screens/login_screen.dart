import 'package:flutter/material.dart';
import 'package:hertzsofts_educare/core/theme.dart';
import 'package:hertzsofts_educare/screens/student/StudentMainScreen.dart';
import 'package:hertzsofts_educare/screens/trainer/trainer_dashboard.dart';
import 'package:hertzsofts_educare/core/auth/DemoAuthHelpor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handle demo login
  Future<void> _handleLogin() async {
    // Get input values
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Validate input
    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter both email and password');
      return;
    }

    // Show loading
    setState(() {
      _isLoading = true;
    });

    // Perform demo login
    final success = await DemoAuthHelper.performDemoLogin(email, password);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Get user type to navigate to correct screen
      final userType = await DemoAuthHelper.getUserType();

      if (!mounted) return;

      // Navigate based on user type
      if (userType == 'student') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const StudentMainScreen()),
        );
      } else if (userType == 'trainer') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const TrainerDashboard()),
        );
      }
    } else {
      // Show error message
      _showErrorDialog('Invalid credentials. Please try:\nStudent: student@demo.com / student123\nTrainer: trainer@demo.com / trainer123');
    }
  }

  /// Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.widgetBackground,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(1, 4),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/logo/main_logo.png",
                      // width: 100,
                      // height: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Form Container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(1, 4),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Welcome Back',
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // // Demo credentials info
                      // Container(
                      //   padding: const EdgeInsets.all(12),
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue[50],
                      //     borderRadius: BorderRadius.circular(12),
                      //     border: Border.all(color: Colors.blue[200]!),
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Icon(Icons.info_outline, size: 18, color: Colors.blue[700]),
                      //           const SizedBox(width: 8),
                      //           Text(
                      //             'Demo Credentials',
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.blue[700],
                      //               fontSize: 13,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(height: 8),
                      //       Text(
                      //         'Student: student@demo.com / student123',
                      //         style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      //       ),
                      //       const SizedBox(height: 4),
                      //       Text(
                      //         'Trainer: trainer@demo.com / trainer123',
                      //         style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 20),

                      // ERP ID / Email field
                      Text(
                        'ERP ID / Email',
                        style: AppTheme.lightTheme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your ERP ID or email',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      Text(
                        'Password',
                        style: AppTheme.lightTheme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          prefixIcon: const Icon(Icons.lock, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onSubmitted: (_) => _handleLogin(),
                      ),
                      const SizedBox(height: 20),

                      // Login Button
                      Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // Get screen width
                            double screenWidth = MediaQuery.of(context).size.width;

                            // Calculate button width based on screen size
                            double buttonWidth;
                            if (screenWidth < 600) {
                              buttonWidth = screenWidth * 0.65;
                              buttonWidth = buttonWidth > 250 ? 250 : buttonWidth;
                            } else if (screenWidth < 1024) {
                              buttonWidth = 300;
                            } else {
                              buttonWidth = 350;
                            }

                            return SizedBox(
                              width: buttonWidth,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: _isLoading
                                        ? const LinearGradient(
                                      colors: [Colors.grey, Colors.grey],
                                    )
                                        : AppColors.topNavGradient,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: _isLoading
                                        ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                      ),
                                    )
                                        : Text(
                                      'Log In',
                                      style: AppTheme.lightTheme.textTheme
                                          .titleMedium
                                          ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Forgot Password
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Forgot Password'),
                                content: const Text(
                                    'This is a demo app. Use the demo credentials provided above.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            'Forgot password?',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // New Student Info
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: AppTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(height: 1.5),
                            children: [
                              const TextSpan(
                                text: 'New student? ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const TextSpan(
                                text:
                                'Registration is handled by your institute ERP system. Please contact your administrator for account setup.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}