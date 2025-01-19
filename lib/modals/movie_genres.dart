class MovieGenres {
  int? id;
  String? name;

  MovieGenres({this.id, this.name});

  MovieGenres.fromJson(Map<String, dynamic> json) {
    try {
      id = (json.containsKey('id') && json['id'] is int) ? json['id'] : null;
      name = (json.containsKey('name') && json['name'] is String) ? json['name'] : null;
    } catch (e) {
      // Log the error if needed
      print("Error parsing MovieGenres: \$e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
