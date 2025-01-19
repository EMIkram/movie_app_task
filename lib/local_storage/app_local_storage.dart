import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tentwenty_task/modals/movie_modal.dart';

class LocalStorageKeys {
  LocalStorageKeys._();
  static const String moviesList = 'movies_list';
}

class LocalStorage {
  static Future<bool> saveMoviesList(List<MovieModal> movies) async {

    final SharedPreferences sp = await SharedPreferences.getInstance();

    final String jsonString = jsonEncode(movies.map((movie) => movie.toJson()).toList());
    return await sp.setString(LocalStorageKeys.moviesList, jsonString);
  }

  static Future<List<MovieModal>> getMoviesList() async {

    final SharedPreferences sp = await SharedPreferences.getInstance();

    final String? jsonString = sp.getString(LocalStorageKeys.moviesList);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> rawList = jsonDecode(jsonString);
      return rawList.map((json) => MovieModal.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
