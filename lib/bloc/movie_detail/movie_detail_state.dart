/// The above code defines various states for a car listing feature in a Flutter application using the
/// BLoC pattern.
part of 'movie_detail_bloc.dart';


abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieVideosFetchedSuccessState extends MovieDetailState {
  final List<MovieVideo> movieVideos;

  MovieVideosFetchedSuccessState({
    required this.movieVideos
  });

  @override
  List<Object> get props => [
    movieVideos
  ];
}

class MovieGenresFetchedSuccessState extends MovieDetailState {
  final List<MovieGenres> movieGenres;

  MovieGenresFetchedSuccessState({
    required this.movieGenres
  });

  @override
  List<Object> get props => [
    movieGenres
  ];
}

class MovieDetailInitialState extends MovieDetailState{}