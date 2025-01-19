class MovieVideo {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  MovieVideo({this.iso6391, this.iso31661, this.name, this.key, this.site, this.size, this.type, this.official, this.publishedAt, this.id});

  MovieVideo.fromJson(Map<String, dynamic> json) {
    try {
      iso6391 = json['iso_639_1'] is String ? json['iso_639_1'] : null;
      iso31661 = json['iso_3166_1'] is String ? json['iso_3166_1'] : null;
      name = json['name'] is String ? json['name'] : null;
      key = json['key'] is String ? json['key'] : null;
      site = json['site'] is String ? json['site'] : null;
      size = json['size'] is int ? json['size'] : null;
      type = json['type'] is String ? json['type'] : null;
      official = json['official'] is bool ? json['official'] : null;
      publishedAt = json['published_at'] is String ? json['published_at'] : null;
      id = json['id'] is String ? json['id'] : null;
    } catch (e) {
      print("Error parsing MovieVideo: \$e");
    }
  }
}
