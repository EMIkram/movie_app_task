/// The above code defines various states for a car listing feature in a Flutter application using the
/// BLoC pattern.
part of 'ticket_bloc.dart';


abstract class TicketState extends Equatable {
  TicketState();
  @override
  List<Object> get props => [];
}

class DateSelectedState extends TicketState{
  final String selectedDate;
   DateSelectedState({required this.selectedDate});
  @override
  List<Object> get props => [
    selectedDate];
}

class SlotSelectedState extends TicketState{
  final String selectedSlot;
   SlotSelectedState({required this.selectedSlot});
  @override
  List<Object> get props => [
    selectedSlot
  ];
}

class TicketInitialState extends TicketState{}