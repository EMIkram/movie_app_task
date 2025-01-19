/// The above code defines various states for a car listing feature in a Flutter application using the
/// BLoC pattern.
part of 'movies_bloc.dart';


abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitialState extends MoviesState {}

class MoviesListState extends MoviesState {
  List<MovieModal> upcomingMoviesList = <MovieModal>[];

  MoviesListState({required this.upcomingMoviesList});

  @override
  List<Object> get props => [upcomingMoviesList];
}

class MoviesListErrorState extends MoviesState {}

class SearchEnabledState extends MoviesState {
  final List<MovieModal> searchList;
  final String? searchedGenre;
  final bool stillSearching;

  SearchEnabledState({
    required this.searchedGenre,
    required this.searchList,
    required this.stillSearching
  });

  @override
  List<Object> get props => [
    searchList,
    searchedGenre ?? "",
    stillSearching
  ];
}
