class TopBanner {
  String? image;
  String? url;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;

  TopBanner(
      {this.image,
      this.url,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime});

  TopBanner.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    url = json['url'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['url'] = url;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }

  bool get isActive {
    if (startDate == null || endDate == null) return true;
    try {
      final now = DateTime.now();
      final start = DateTime.parse(startDate!);
      final end = DateTime.parse(endDate!).add(const Duration(hours: 23, minutes: 59, seconds: 59));
      return now.isAfter(start) && now.isBefore(end);
    } catch (e) {
      return true;
    }
  }
}