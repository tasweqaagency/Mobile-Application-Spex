class NotificationModel {
  final int id;
  final String title;
  final String body;
  final DateTime time;
  final bool isRead;
  final String? image;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    this.isRead = false,
    this.image,
  });
}
