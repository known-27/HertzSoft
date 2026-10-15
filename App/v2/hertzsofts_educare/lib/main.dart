import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hertzsofts_educare/screens/student/StudentMainScreen.dart';
import 'package:hertzsofts_educare/screens/trainer/TrainerMainScreen.dart';
import 'screens/splash_screen.dart';
import 'screens/common_screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme.dart';
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
        nextScreen: const AuthCheck(),
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final userToken = prefs.getString('userToken');
      final userType = prefs.getString('userType');

      // Small delay to ensure smooth transition from splash
      await Future.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      // Set loading state before navigation
      setState(() {
        _isLoading = true;
      });

      // Small delay to show the loading indicator
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      Widget nextScreen;

      if (isLoggedIn && userToken != null && userToken.isNotEmpty) {
        if (userType == 'student') {
          nextScreen = const StudentMainScreen();
        } else if (userType == 'trainer') {
          nextScreen = const TrainerMainScreen();
        } else {
          nextScreen = const LoginScreen();
        }
      } else {
        nextScreen = const LoginScreen();
      }

      // Navigate to the appropriate screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    } catch (e) {
      // Handle any errors during auth check
      if (!mounted) return;

      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _isLoading ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientCircularProgress(
                size: 60,
                strokeWidth: 5.0,
                gradientColors: [
                  Color(0xFF6366F1),
                  Color(0xFF8B5CF6),
                  Color(0xFFA855F7),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Loading...',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientCircularProgress extends StatefulWidget {
  final double size;
  final List<Color>? gradientColors;
  final double strokeWidth;

  const GradientCircularProgress({
    super.key,
    this.size = 50.0,
    this.gradientColors,
    this.strokeWidth = 4.0,
  });

  @override
  State<GradientCircularProgress> createState() =>
      _GradientCircularProgressState();
}

class _GradientCircularProgressState extends State<GradientCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.gradientColors ??
        [
          const Color(0xFF6366F1),
          const Color(0xFF8B5CF6),
          const Color(0xFFA855F7),
        ];

    return RotationTransition(
      turns: _controller,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _GradientCircularProgressPainter(
          colors: colors,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final List<Color> colors;
  final double strokeWidth;

  _GradientCircularProgressPainter({
    required this.colors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = SweepGradient(
      colors: [...colors, colors.first],
      stops: const [0.0, 0.5, 0.9, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      1.5 * pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}