class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final List<String> categories;
  final double rating;
  final int students;
  final String imageUrl;
  final bool isFavorite;
  final String duration;
  final String level;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.categories,
    required this.rating,
    required this.students,
    required this.imageUrl,
    this.isFavorite = false,
    required this.duration,
    required this.level,
  });

  Course copyWith({
    String? id,
    String? title,
    String? description,
    String? instructor,
    List<String>? categories,
    double? rating,
    int? students,
    String? imageUrl,
    bool? isFavorite,
    String? duration,
    String? level,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      categories: categories ?? this.categories,
      rating: rating ?? this.rating,
      students: students ?? this.students,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      duration: duration ?? this.duration,
      level: level ?? this.level,
    );
  }
}