
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/modals/movie_genres.dart';
import 'package:tentwenty_task/modals/movie_video.dart';
import 'package:tentwenty_task/repository/movies_repo.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  MoviesRepo moviesRepo = MoviesRepo();

  ///Dummy seating just for UI
  List<List<int>> seatings = [
    [0,0,0,2,1,0,1,1,1,1,1,1,1,2,3,3,0,1,1,0,0,0],
    [0,1,1,1,1,0,1,2,1,2,1,2,1,2,1,1,0,1,2,1,1,0],
    [0,1,1,1,1,0,1,2,1,2,1,2,1,2,1,1,0,1,2,1,1,0],
    [0,1,1,1,1,0,1,2,1,2,1,2,1,2,1,1,0,1,2,1,1,0],
    [0,1,1,1,1,0,1,2,1,2,1,2,1,2,1,1,0,1,2,1,1,0],
    [2,1,1,1,1,0,1,2,1,2,1,2,1,2,1,1,0,1,2,1,1,1],
    [2,1,1,1,1,0,1,2,1,2,1,2,1,2,1,1,0,1,2,1,1,1],
    [2,1,1,1,1,0,1,2,1,2,1,2,1,2,1,1,0,1,2,1,1,1],
    [2,1,1,1,1,0,1,2,1,2,1,2,1,2,1,1,0,1,2,1,1,1],
    [3,3,3,3,3,0,1,4,4,4,4,4,4,4,1,1,0,1,3,3,3,1],
  ];
  String selectedDate = '';
  String selectedSlot = '';

  TicketBloc() : super(TicketInitialState()) {
    on<SelectDateEvent>(_selectDate);
    on<SelectSlotEvent>(_selectSlot);
  }

  _selectDate(SelectDateEvent event, emit){
    selectedDate = event.date;
    emit(DateSelectedState(
        selectedDate: selectedDate));
  }

  _selectSlot(SelectSlotEvent event, emit){
    selectedSlot = event.slot;
    emit(DateSelectedState(
        selectedDate: selectedDate));
  }
}
