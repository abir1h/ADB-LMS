class DiscussionDataEntity {
  final String id;
  final String disscussionType;
  final String material;
  final String exam;
  final String mockTest;
  final String comment;
  final String commentatorType;
  final String commentTime;
  final bool isSelfComment;
  final String email;
  final String phoneNumber;
  final String imagePath;
  final String commenterName;

  const DiscussionDataEntity({
    required this.id,
    required this.disscussionType,
    required this.material,
    required this.exam,
    required this.mockTest,
    required this.comment,
    required this.commentatorType,
    required this.commentTime,
    required this.isSelfComment,
    required this.email,
    required this.phoneNumber,
    required this.imagePath,
    required this.commenterName,
  });
}