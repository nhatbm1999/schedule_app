// ignore_for_file: must_be_immutable

part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class FetchEvent extends EventEvent {
  const FetchEvent({required this.userId});
  final String userId;
}
class CheckRegisterEvent extends EventEvent {
  CheckRegisterEvent({required this.isRegistered});
  bool isRegistered;
}
class FetchUser extends EventEvent {
  final String userId;
  const FetchUser({
    required this.userId,
  });
}
class RegisteredEvent extends EventEvent {
    const RegisteredEvent({
    required this.userId,
    required this.eventId,
    required this.eventName,
    required this.eventDescription,
    required this.eventImage,
    required this.eventLocationLatitude,
    required this.eventLocationLongitude,
    required this.startTime,
    required this.endTime,
    required this.isAllDay,
  });
    final String userId;
    final String eventId;
    final String eventName;
    final String eventDescription;
    final String eventImage;
    final double eventLocationLatitude;
    final double eventLocationLongitude;
    final DateTime startTime;
    final DateTime endTime;
    final bool isAllDay; 
}
class UnregisteredEvent extends EventEvent {
  final String eventId;
  final String userId;
  const UnregisteredEvent({
    required this.eventId,
    required this.userId,
  });
}
