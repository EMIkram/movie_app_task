
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/modals/movie_modal.dart';
import 'package:tentwenty_task/repository/movies_repo.dart';

import '../../local_storage/app_local_storage.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesRepo moviesRepo = MoviesRepo();

  ///Data
  bool searchFieldEnabled = false;
  List<MovieModal> upcomingMoviesList = <MovieModal>[];
  List<MovieModal> searchList = <MovieModal>[];
  String? searchedGenre;
  bool isSearching = false;

  MoviesBloc() : super(MoviesInitialState()) {
    on<GetUpcomingMoviesEvent>(_getMoviesList);
    on<DisableSearchEvent>(_disableSearchEvent);
    on<EnableSearchEvent>(_enableSearchEvent);
    on<SearchByQueryEvent>(_searchByQuery);
    on<SearchByGenreEvent>(_searchByGenre);
    on<SearchFieldClearEvent>(_searchFieldClear);

    ///first event
    add(GetUpcomingMoviesEvent());

    loadMoviesListFromCache();
  }


  loadMoviesListFromCache() async{
   upcomingMoviesList = await  LocalStorage.getMoviesList();
    emit(MoviesListState(upcomingMoviesList: upcomingMoviesList));
  }

  saveMoviesListToCache(){
    LocalStorage.saveMoviesList(upcomingMoviesList);
  }

  void _getMoviesList(
      GetUpcomingMoviesEvent event, Emitter<MoviesState> emit) async {
    try {
      await moviesRepo
          .getUpcomingMovies()
          .then((value) {
        if (value['results'] != null) {
          List<dynamic> jsonList = value['results'];
          upcomingMoviesList =
              jsonList.map((json) => MovieModal.fromJson(json)).toList();
          emit(MoviesListState(upcomingMoviesList: upcomingMoviesList));
          saveMoviesListToCache();
        }
      });
    } catch (e,s) {
      print(e.toString());
      emit(MoviesInitialState());
    }
  }

  void _searchByQuery(
      SearchByQueryEvent event, Emitter<MoviesState> emit) async {
    try {
      await moviesRepo
          .searchbyQuery(event.query)
          .then((value) {
        if (value['results'] != null) {
          List<dynamic> jsonList = value['results'];
            searchList =
                jsonList.map((json) => MovieModal.fromJson(json)).toList();
          emit(SearchEnabledState(searchedGenre: searchedGenre, searchList: searchList, stillSearching: true));
        }
      });
    } catch (e,s) {
      print(e.toString());
    }
  }

  void _searchByGenre(
      SearchByGenreEvent event, Emitter<MoviesState> emit) async {
    try {
      await moviesRepo
          .searchbyGenreID(event.genreID)
          .then((value) {
        if (value['results'] != null) {
          List<dynamic> jsonList = value['results'];
          searchList =
              jsonList.map((json) => MovieModal.fromJson(json)).toList();
          emit(SearchEnabledState(searchedGenre: event.genreName, searchList: searchList, stillSearching: true));
        }
      });
    } catch (e,s) {
      print(e.toString());
    }
  }


  void _disableSearchEvent(DisableSearchEvent event,emit) async {
    searchList.clear();
    searchedGenre = "";
    emit(MoviesListState(upcomingMoviesList: upcomingMoviesList));
  }

  void _enableSearchEvent(EnableSearchEvent event,emit) async {
    emit(SearchEnabledState(searchedGenre: searchedGenre, searchList: searchList, stillSearching: event.stillSearching));
  }

  void _searchFieldClear(SearchFieldClearEvent event,emit) async {
    // emit(SearchEnabledState(searchedGenre: searchedGenre, searchList: [], stillSearching: true));
  searchList =[];
  }


  _resetEvent(event, emit) {
    emit(MoviesInitialState());
  }

}
