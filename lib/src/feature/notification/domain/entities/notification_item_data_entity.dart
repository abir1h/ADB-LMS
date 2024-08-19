class NotificationItemDataEntity {
  final String id;
  final String title;
  final String details;
  final String createdOn;
  final String creatorName;
  final String creatorEmail;
  final String creatorPhoneNumber;
  final String notificationType;
  final String payload;
  final String navigateTo;
  final bool seen;

  const NotificationItemDataEntity({
    required this.id,
    required this.title,
    required this.details,
    required this.createdOn,
    required this.creatorName,
    required this.creatorEmail,
    required this.creatorPhoneNumber,
    required this.notificationType,
    required this.payload,
    required this.navigateTo,
    required this.seen,
  });
}
