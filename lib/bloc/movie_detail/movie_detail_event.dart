part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class GetGenresByMovieIdEvent extends MovieDetailEvent{
  final String movieID;
  const GetGenresByMovieIdEvent({required this.movieID});
   @override
  List<Object> get props => [movieID];
}

class GetVideosByMovieIdEvent extends MovieDetailEvent{
  final String movieID;
  const GetVideosByMovieIdEvent({required this.movieID});
  @override
  List<Object> get props => [movieID];
}