import 'package:flutter/material.dart';
import 'package:hertzsofts_educare/core/theme.dart';
import '../../features/data/models/category.dart';
import '../../features/data/models/course.dart';
import '../../features/data/data_sources/mock_course_data.dart';
import '../widget/SearchBar.dart';

class AllCourses extends StatefulWidget {
  final String? initialCategory;
  final String? initialSearchQuery;
  final bool showFavorites;

  const AllCourses({
    super.key,
    this.initialCategory,
    this.initialSearchQuery,
    this.showFavorites = false,
  });

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  List<Course> _allCourses = [];
  List<Course> _filteredCourses = [];
  String _searchQuery = '';
  bool _isFavoriteFilterActive = false;
  String? _activeCategoryFilter;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _allCourses = MockCourseData.getAllCourses();
        _searchQuery = widget.initialSearchQuery ?? '';
        _activeCategoryFilter = widget.initialCategory;
        _isFavoriteFilterActive = widget.showFavorites;
        _isLoading = false;
      });
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredCourses = _allCourses;

      // Apply category filter
      if (_activeCategoryFilter != null && _activeCategoryFilter!.isNotEmpty) {
        _filteredCourses = _filteredCourses
            .where((course) => course.categories.contains(_activeCategoryFilter))
            .toList();
      }

      // Apply search query filter
      if (_searchQuery.isNotEmpty) {
        final lowercaseQuery = _searchQuery.toLowerCase();
        _filteredCourses = _filteredCourses
            .where((course) =>
        course.title.toLowerCase().contains(lowercaseQuery) ||
            course.description.toLowerCase().contains(lowercaseQuery) ||
            course.instructor.toLowerCase().contains(lowercaseQuery))
            .toList();
      }

      // Apply favorite filter
      if (_isFavoriteFilterActive) {
        _filteredCourses =
            _filteredCourses.where((course) => course.isFavorite).toList();
      }
    });
  }

  void _handleSearch(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _handleFavoriteToggle() {
    _isFavoriteFilterActive = !_isFavoriteFilterActive;
    _applyFilters();
  }

  void _clearCategoryFilter() {
    setState(() {
      _activeCategoryFilter = null;
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    final category = _activeCategoryFilter != null
        ? CategoryData.getCategoryByFilterTag(_activeCategoryFilter!)
        : null;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.topNavGradient,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Courses',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        color: AppColors.background,
        child: Column(
          children: [
            // Search Bar Section
            SearchBarWithFavorite(
              onSearchChanged: _handleSearch,
              onFavoritePressed: _handleFavoriteToggle,
              isFavorite: _isFavoriteFilterActive,
            ),

            // Active Filters Row
            if (category != null || _isFavoriteFilterActive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (category != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            avatar: Icon(
                              category.icon,
                              size: 18,
                              color: Colors.white,
                            ),
                            label: Text(
                              category.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                            deleteIcon: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                            onDeleted: _clearCategoryFilter,
                            backgroundColor: AppColors.primary,
                          ),
                        ),
                      if (_isFavoriteFilterActive)
                        Chip(
                          avatar: const Icon(
                            Icons.favorite,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Favorites',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          deleteIcon: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.white,
                          ),
                          onDeleted: _handleFavoriteToggle,
                          backgroundColor: Colors.red,
                        ),
                    ],
                  ),
                ),
              ),

            // Results Count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_filteredCourses.length} courses found',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Sort button (optional)
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Implement sort functionality
                    },
                    icon: Icon(
                      Icons.sort,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    label: Text(
                      'Sort',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Course List
            Expanded(
              child: _isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : _filteredCourses.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredCourses.length,
                itemBuilder: (context, index) {
                  return CourseCard(
                    course: _filteredCourses[index],
                    onTap: () {
                      // TODO: Navigate to course details
                      print('Tapped on: ${_filteredCourses[index].title}');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 24),
            Text(
              'No courses found',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Try adjusting your filters or search query',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _activeCategoryFilter = null;
                  _isFavoriteFilterActive = false;
                });
                _applyFilters();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Clear All Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
            // Course Image with Trending Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppColors.trendingGradient,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 60,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                // Trending Badge
                if (course.rating >= 4.7)
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
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                // Favorite Icon
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      course.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: course.isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),

            // Course Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Duration and Modules
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        course.duration,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.apps,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Modules Included',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    course.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < course.rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          size: 16,
                          color: Colors.amber,
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}