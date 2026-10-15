import 'package:flutter/material.dart';

import '../../core/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    // border: Border.all(
                    //   color: Colors.blue[300]!,
                    //   width: 2,
                    // ),
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
                          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(fontWeight: .bold)
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ERP ID / Email field
                      Text(
                        'ERP ID / Email',
                        style: AppTheme.lightTheme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
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
                      const SizedBox(height: 20),

                      // Login Button
                      Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // Get screen width
                            double screenWidth = MediaQuery.of(
                              context,
                            ).size.width;

                            // Calculate button width based on screen size
                            // Mobile: 250px, Tablet: 300px, Desktop: 350px
                            double buttonWidth;
                            if (screenWidth < 600) {
                              // Mobile
                              buttonWidth =
                                  screenWidth *
                                  0.65; // 65% of screen width, max 250
                              buttonWidth = buttonWidth > 250
                                  ? 250
                                  : buttonWidth;
                            } else if (screenWidth < 1024) {
                              // Tablet
                              buttonWidth = 300;
                            } else {
                              // Desktop
                              buttonWidth = 350;
                            }

                            return SizedBox(
                              width: buttonWidth,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle login
                                },
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
                                    gradient: AppColors.topNavGradient,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Log In',
                                      style: AppTheme
                                          .lightTheme
                                          .textTheme
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
