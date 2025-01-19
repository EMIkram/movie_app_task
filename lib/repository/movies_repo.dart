import 'dart:developer';

import '../networks/base_api_services.dart';
import '../networks/network_api_services.dart';
import '../utils/api_endpoints.dart';

class MoviesRepo {

  final BaseApiServices _apiServices = NetworkApiService();

  /// get upcoming movies list
  Future<dynamic> getUpcomingMovies() async {
    try {
      dynamic response;
      response = await _apiServices.getApiResponse(
          ApiEndpoints.getAllMovies);
      return response;
    } catch (e, s) {
      log("Exception $e");
      log("stacktrace $s");
      rethrow;
    }
  }


  /// movie details API
  Future<dynamic> getMovieGenres(String movieID) async {
    try {
      dynamic response;
      response = await _apiServices.getApiResponse(
          ApiEndpoints.getMovieGenresByMovieID(movieID));
      return response; //['genres']
    } catch (e, s) {
      log("Exception $e");
      log("stacktrace $s");
      rethrow;
    }

  }



  /// movie videos API
  Future<dynamic>  getMovieVideos(String movieID) async {
    try {
      dynamic response;
      response = await _apiServices.getApiResponse(
          ApiEndpoints.getMovieVideosByMovieID(movieID));
      return response;// ['results']
    } catch (e, s) {
      log("Exception $e");
      log("stacktrace $s");
      rethrow;
    }

  }


  /// search by genre id
  Future<dynamic>  searchbyGenreID(String genreID) async {
    try {
      dynamic response;
      response = await _apiServices.getApiResponse(
          ApiEndpoints.searchMoviesByGenreID(genreID));
      return response; //['results']
    } catch (e, s) {
      log("Exception $e");
      log("stacktrace $s");
      rethrow;
    }
  }

  Future<dynamic> searchbyQuery(String query) async {
    try {
      dynamic response;
      response = await _apiServices.getApiResponse(
          ApiEndpoints.searchMoviesByQuery(query));
      return response; //['results']
    } catch (e, s) {
      log("Exception $e");
      log("stacktrace $s");
      rethrow;
    }
  }


}
