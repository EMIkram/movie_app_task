class MovieModal {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieModal({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount
  });

  MovieModal.fromJson(Map<String, dynamic> json) {
    try {
      adult = json.containsKey('adult') ? json['adult'] as bool? : null;
      backdropPath = json.containsKey('backdrop_path') ? json['backdrop_path'] as String? : null;
      genreIds = json.containsKey('genre_ids') && json['genre_ids'] is List<dynamic>
          ? List<int>.from(json['genre_ids'])
          : null;
      id = json.containsKey('id') ? json['id'] as int? : null;
      originalLanguage = json.containsKey('original_language') ? json['original_language'] as String? : null;
      originalTitle = json.containsKey('original_title') ? json['original_title'] as String? : null;
      overview = json.containsKey('overview') ? json['overview'] as String? : null;
      popularity = json.containsKey('popularity') ? (json['popularity'] as num?)?.toDouble() : null;
      posterPath = json.containsKey('poster_path') ? json['poster_path'] as String? : null;
      releaseDate = json.containsKey('release_date') ? json['release_date'] as String? : null;
      title = json.containsKey('title') ? json['title'] as String? : null;
      video = json.containsKey('video') ? json['video'] as bool? : null;
      voteAverage = json.containsKey('vote_average') ? (json['vote_average'] as num?)?.toDouble() : null;
      voteCount = json.containsKey('vote_count') ? json['vote_count'] as int? : null;
    } catch (e) {
      print("Error parsing MovieModal: \$e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
