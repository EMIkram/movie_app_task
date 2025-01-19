
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/modals/movie_genres.dart';
import 'package:tentwenty_task/modals/movie_video.dart';
import 'package:tentwenty_task/repository/movies_repo.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MoviesRepo moviesRepo = MoviesRepo();


  MovieDetailBloc() : super(MovieDetailInitialState()) {
    on<GetVideosByMovieIdEvent>(_getVideosById);
    on<GetGenresByMovieIdEvent>(_getGenresById);
  }



    void _getVideosById(
        GetVideosByMovieIdEvent event, Emitter<MovieDetailState> emit) async {
    try {
      await moviesRepo
          .getMovieVideos(event.movieID)
          .then((value) {
        if (value['results'] != null) {
          List<dynamic> jsonList = value['results'] ?? [];
          List<MovieVideo> movieVideos = <MovieVideo>[];
          jsonList.forEach((json) {
              movieVideos.add(MovieVideo.fromJson(json));
            });

          emit(MovieVideosFetchedSuccessState(movieVideos: movieVideos));
        }
      });
    } catch (e,s) {
    }
  }

  void _getGenresById(GetGenresByMovieIdEvent event, Emitter<MovieDetailState> emit) async {
    try {
      await moviesRepo
          .getMovieGenres(event.movieID)
          .then((value) {
        if (value['genres'] != null) {
          List<dynamic> jsonList = value['genres'];
          List<MovieGenres> movieGenres = <MovieGenres>[];
          jsonList.forEach((json) {
            movieGenres.add(MovieGenres.fromJson(json));
          });
          emit(MovieGenresFetchedSuccessState(movieGenres: movieGenres));
        }
      });
    } catch (e,s) {
    }
  }


}
