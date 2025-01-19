part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class SelectDateEvent extends TicketEvent{
  final String date;
  const SelectDateEvent({required this.date});
   @override
  List<Object> get props => [date];
}

class SelectSlotEvent extends TicketEvent{
  final String slot;
  const SelectSlotEvent({required this.slot});
  @override
  List<Object> get props => [slot];
}