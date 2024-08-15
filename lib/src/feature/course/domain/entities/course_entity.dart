class CourseEntity {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final int rating;
  final int noOfRating;
  final bool published;
  final bool bookmarked;
  final int progress;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.rating,
    required this.noOfRating,
    required this.published,
    required this.bookmarked,
    required this.progress,
  });}