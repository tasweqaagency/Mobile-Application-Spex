class SliderBanner {
  String? image;
  String? link;

  SliderBanner({this.image, this.link});

  SliderBanner.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['link'] = link;
    return data;
  }
}