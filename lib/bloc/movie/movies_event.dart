part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetUpcomingMoviesEvent extends MoviesEvent {}

class DisableSearchEvent extends MoviesEvent {}

class EnableSearchEvent extends MoviesEvent {
  final bool stillSearching;
  const EnableSearchEvent({required this.stillSearching});
  @override
  List<Object> get props => [stillSearching];
}

class SearchByQueryEvent extends MoviesEvent {
  final String query;
  final bool stillSearching;
  const SearchByQueryEvent({required this.query, required this.stillSearching});
  @override
  List<Object> get props => [query, stillSearching];
}

class SearchByGenreEvent extends MoviesEvent {
  final String genreID;
  final bool stillSearching;
  final String genreName;
  const SearchByGenreEvent({required this.genreID, required this.stillSearching, required this.genreName});
  @override
  List<Object> get props => [genreID, stillSearching, genreName];
}

class SearchFieldClearEvent extends MoviesEvent{}
