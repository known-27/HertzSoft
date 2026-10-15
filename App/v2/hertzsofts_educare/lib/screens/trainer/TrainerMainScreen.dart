import 'package:flutter/material.dart';
import '../widget/trainerbottomNavbar.dart';
import 'trainer_dashboard.dart';

class TrainerMainScreen extends StatefulWidget {
  const TrainerMainScreen({super.key});

  @override
  State<TrainerMainScreen> createState() => _TrainerMainScreenState();
}

class _TrainerMainScreenState extends State<TrainerMainScreen> {
  int _currentIndex = 0;

  // List of screens for each tab
  final List<Widget> _screens = [
    const TrainerDashboard(),
    // const ChatRoutes(),
    // const TrainersProfile(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: TrainerBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}