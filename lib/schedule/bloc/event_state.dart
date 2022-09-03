part of 'event_bloc.dart';

class EventState extends Equatable {
  EventState({
    this.status = LoadStatus.initial,
    this.registerStatus = FormzStatus.pure,
    this.errorMessage = '',
    this.events,
    this.isRegistered = false,
    this.user,
  });

  final LoadStatus status;
  final FormzStatus registerStatus;
  final String errorMessage;
  final List<EventModel>? events;
  bool? isRegistered;
  final User? user;

  EventState copyWith({
    LoadStatus? status,
    String? errorMessage,
    List<EventModel>? events,
    bool? isRegistered,
    FormzStatus? registerStatus,
    User? user,
    LoadStatus? getEventInfo,
  }) {
    return EventState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
      isRegistered: isRegistered ?? this.isRegistered,
      registerStatus: registerStatus ?? this.registerStatus,
      user: user ?? this.user,
    );
  }

  
  @override
  List<Object?> get props => [
    status,
    errorMessage,
    events,
    isRegistered,
    registerStatus,
    user,
  ];
}
