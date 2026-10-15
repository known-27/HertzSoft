import '../models/course.dart';

class MockCourseData {
  static List<Course> getAllCourses() {
    return [
      Course(
        id: '1',
        title: 'Flutter Mobile Development Workshop',
        description: 'Learn to build beautiful mobile apps with Flutter',
        instructor: 'John Doe',
        categories: ['workshop', 'beginner'],
        rating: 4.8,
        students: 1250,
        imageUrl: 'https://via.placeholder.com/300x200',
        duration: '2 days',
        level: 'Beginner',
      ),
      Course(
        id: '2',
        title: 'React Native Basics',
        description: 'Quick introduction to React Native development',
        instructor: 'Jane Smith',
        categories: ['short_term', 'beginner'],
        rating: 4.5,
        students: 890,
        imageUrl: 'https://via.placeholder.com/300x200',
        duration: '4 weeks',
        level: 'Beginner',
      ),
      Course(
        id: '3',
        title: 'Advanced System Design',
        description: 'Master complex system architecture patterns',
        instructor: 'Mike Johnson',
        categories: ['advanced', 'certification'],
        rating: 4.9,
        students: 560,
        imageUrl: 'https://via.placeholder.com/300x200',
        duration: '12 weeks',
        level: 'Advanced',
      ),
      Course(
        id: '4',
        title: 'UI/UX Design Workshop',
        description: 'Create stunning user interfaces',
        instructor: 'Sarah Williams',
        categories: ['workshop', 'short_term'],
        rating: 4.7,
        students: 2100,
        imageUrl: 'https://via.placeholder.com/300x200',
        duration: '3 days',
        level: 'Intermediate',
      ),
      Course(
        id: '5',
        title: 'Cloud Computing Fundamentals',
        description: 'Learn AWS, Azure, and Google Cloud basics',
        instructor: 'David Brown',
        categories: ['short_term', 'beginner', 'certification'],
        rating: 4.6,
        students: 1800,
        imageUrl: 'https://via.placeholder.com/300x200',
        duration: '6 weeks',
        level: 'Beginner',
      ),
      Course(
        id: '6',
        title: 'Machine Learning Masterclass',
        description: 'Deep dive into ML algorithms and applications',
        instructor: 'Emily Davis',
        categories: ['advanced', 'certification'],
        rating: 4.9,
        students: 670,
        imageUrl: 'https://via.placeholder.com/300x200',
        duration: '16 weeks',
        level: 'Advanced',
      ),
      Course(
        id: '7',
        title: 'Python Programming Workshop',
        description: 'Hands-on Python coding workshop',
        instructor: 'Robert Wilson',
        categories: ['workshop', 'beginner'],
        rating: 4.7,
        students: 3200,
        imageUrl: 'https://via.placeholder.com/300x200',
        duration: '1 day',
        level: 'Beginner',
      ),
      Course(
        id: '8',
        title: 'Web Development Bootcamp',
        description: 'Complete web development from scratch',
        instructor: 'Lisa Anderson',
        categories: ['short_term', 'beginner', 'certification'],
        rating: 4.8,
        students: 2500,
        imageUrl: 'https://via.placeholder.com/300x200',
        duration: '8 weeks',
        level: 'Beginner',
      ),
    ];
  }

  // You can add methods to filter courses
  static List<Course> getCoursesByCategory(String categoryFilter) {
    return getAllCourses()
        .where((course) => course.categories.contains(categoryFilter))
        .toList();
  }

  static List<Course> searchCourses(String query) {
    final lowercaseQuery = query.toLowerCase();
    return getAllCourses()
        .where((course) =>
    course.title.toLowerCase().contains(lowercaseQuery) ||
        course.description.toLowerCase().contains(lowercaseQuery) ||
        course.instructor.toLowerCase().contains(lowercaseQuery))
        .toList();
  }

  static List<Course> getFavoriteCourses() {
    return getAllCourses().where((course) => course.isFavorite).toList();
  }
}