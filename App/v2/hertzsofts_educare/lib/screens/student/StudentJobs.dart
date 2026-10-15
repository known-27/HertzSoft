import 'package:flutter/material.dart';

class StudentJobs extends StatefulWidget {
  const StudentJobs({super.key});

  @override
  State<StudentJobs> createState() => _StudentJobsState();
}

class _StudentJobsState extends State<StudentJobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
      ),
      body: Center(
        child: Text(
          'Jobs',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}