part of 'event_bloc.dart';

class EventState extends Equatable {
  const EventState({
    this.status = LoadStatus.initial,
    this.errorMessage = '',
    this.events,
  });

  final LoadStatus status;
  final String errorMessage;
  final List<EventModel>? events;

  EventState copyWith({
    LoadStatus? status,
    String? errorMessage,
    List<EventModel>? events,
  }) {
    return EventState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
    );
  }

  
  @override
  List<Object?> get props => [
    status,
    errorMessage,
    events,
  ];
}
