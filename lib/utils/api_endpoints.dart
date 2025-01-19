
import 'package:tentwenty_task/environment.dart';

class ApiEndpoints {
  ApiEndpoints._();
  static EnvironmentType env = Environment.instance.environmentType; ///change environment here

  ///Base url is now dynamically picked from .env file there is still flexibility to change the Url here if the environment is not PRODUCTION
static get baseUrl {
  return Environment.instance.apiBaseUrl;
}

static get _apiKey {
  return Environment.instance.apiKey;
}

///Endpoints

  static String getAllMovies = "$baseUrl/movie/upcoming?api_key=$_apiKey";
  static String getMovieGenresByMovieID(String movieID) => "$baseUrl/movie/$movieID?api_key=$_apiKey";
  static String getMovieVideosByMovieID(String movieID) => "$baseUrl/movie/$movieID/videos?api_key=$_apiKey";
  static String searchMoviesByGenreID(String genreID) => "$baseUrl/discover/movie?with_genres=$genreID&api_key=$_apiKey";
  static String searchMoviesByQuery(String query) => "$baseUrl/search/movie?query=$query&limit=100&api_key=$_apiKey";

}
