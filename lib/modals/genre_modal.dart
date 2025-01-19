class DummyGenres {
  int? id;
  String? name;
  String? imageUrl;

  DummyGenres({this.id, this.name, this.imageUrl});

  DummyGenres.fromJson(Map<String, dynamic> json) {
    try {
      id = (json.containsKey('id') && json['id'] is int) ? json['id'] : null;
      name = (json.containsKey('name') && json['name'] is String) ? json['name'] : null;
      imageUrl = (json.containsKey('ImageUrl') && json['ImageUrl'] is String) ? json['ImageUrl'] : null;
    } catch (e) {
      // Log the error if needed
      print("Error parsing DummyGenres: \$e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['ImageUrl'] = imageUrl;
    return data;
  }

  static List<DummyGenres> getDummyGeres() {
    List<Map<String, dynamic>> rawList = [
      {
        "id": 35,
        "name": "Comedies",
        "ImageUrl": "assets/images/comedies.jpg"
      },
      {
        "id": 80,
        "name": "Crime",
        "ImageUrl": "assets/images/crimes.jpg"
      },
      {
        "id": 10751,
        "name": "Family",
        "ImageUrl": "assets/images/family.jpg"
      },
      {
        "id": 99,
        "name": "Documentaries",
        "ImageUrl": "assets/images/documentries.jpg"
      },
      {
        "id": 18,
        "name": "Drama",
        "ImageUrl": "assets/images/dramas.jpg"
      },
      {
        "id": 14,
        "name": "Fantasy",
        "ImageUrl": "assets/images/fantasy.jpg"
      },
      {
        "id": 27,
        "name": "Horror",
        "ImageUrl": "assets/images/horror.jpg"
      },
      {
        "id": 878,
        "name": "Sci-Fi",
        "ImageUrl": "assets/images/sci_fi.jpg"
      },
      {
        "id": 53,
        "name": "Thriller",
        "ImageUrl": "assets/images/thriller.jpg"
      }
    ];
    return rawList.map((e) => DummyGenres.fromJson(e)).toList();
  }
}
