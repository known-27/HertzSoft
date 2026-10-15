import 'package:flutter/material.dart';

import '../widget/AppBar.dart';
import '../widget/SearchBar.dart';
import '../widget/categories_filter_section.dart';
import '../../features/data/models/category.dart';
import 'allCourses.dart';
import 'package:hertzsofts_educare/core/theme.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  bool _isFavoriteFilterActive = false;
  String _searchQuery = '';

  void _handleSearch(String query) {
    // Navigate to AllCourses screen when user types in search
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AllCourses(
            initialSearchQuery: query,
          ),
        ),
      );
    }
  }

  void _handleFavoriteToggle() {
    // Navigate to AllCourses screen with favorite filter active
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllCourses(
          showFavorites: true,
        ),
      ),
    );
  }

  void _handleCategoryTap(Category category) {
    // Navigate to AllCourses screen with the selected category filter
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllCourses(
          initialCategory: category.filterTag,
        ),
      ),
    );
  }

  void _navigateToAllCourses() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllCourses(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StudentAppBar(),
      body: Container(
        color: AppColors.background,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search Bar Section
              SearchBarWithFavorite(
                onSearchChanged: _handleSearch,
                onFavoritePressed: _handleFavoriteToggle,
                isFavorite: _isFavoriteFilterActive,
              ),

              // Categories Filter Section
              CategoriesFilterSection(
                onCategoryTap: _handleCategoryTap,
              ),

              // const SizedBox(height: 4),

              // Content Area
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enrolled Batches Section
                    _buildSectionHeader('Enrolled Batches', showViewAll: true),
                    const SizedBox(height: 12),
                    _buildEnrolledBatchesGrid(),

                    const SizedBox(height: 24),

                    // Upcoming Batches Section
                    _buildSectionHeader('Upcoming Batches', showViewAll: true),
                    const SizedBox(height: 12),
                    _buildUpcomingBatchesList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool showViewAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        if (showViewAll)
          TextButton(
            onPressed: _navigateToAllCourses,
            child: const Text(
              'View All',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEnrolledBatchesGrid() {
    return SizedBox(
      height: 260,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildEnrolledBatchCard(
            title: 'Development With Gen AI',
            duration: '5 Days',
            progress: 0.4,
            schedule: 'TUE 2PM - 3PM',
            gradient: const LinearGradient(
              colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
            ),
            isTrending: true,
          ),
          const SizedBox(width: 16),
          _buildEnrolledBatchCard(
            title: 'Core Python Program',
            duration: '10 Days',
            progress: 0.65,
            schedule: 'WED 2PM - 3PM',
            gradient: const LinearGradient(
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ),
            isMostPopular: true,
          ),
        ],
      ),
    );
  }

  Widget _buildEnrolledBatchCard({
    required String title,
    required String duration,
    required double progress,
    required String schedule,
    required Gradient gradient,
    bool isTrending = false,
    bool isMostPopular = false,
  }) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Image/Header
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Icon(
                        Icons.code,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              if (isTrending)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.notification,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Trending',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (isMostPopular)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Most Popular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Course Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.apps,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Modules Included',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF4CAF50),
                    ),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.priceTagColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        schedule,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingBatchesList() {
    return Column(
      children: [
        _buildUpcomingBatchCard(
          title: 'Core Java Programming',
          duration: '10 Days',
          gradient: const LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
        ),
        const SizedBox(height: 12),
        _buildUpcomingBatchCard(
          title: 'Web Development Bootcamp',
          duration: '8 Weeks',
          gradient: const LinearGradient(
            colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingBatchCard({
    required String title,
    required String duration,
    required Gradient gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Image/Header
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.laptop_mac,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Coming Soon',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Course Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            duration,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.apps,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Modules Included',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}