import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  const EventModel({
    required this.id,
    required this.eventName,
    this.eventDescription,
    required this.eventImage,
    required this.eventLocationLongitude,
    required this.eventLocationLatitude,
    required this.startTime,
    required this.endTime,
    required this.isAllDay,
  });

  final String id;
  final String eventName;
  final String? eventDescription;
  final String eventImage;
  final double eventLocationLongitude;
  final double eventLocationLatitude;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAllDay;

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'],
      eventName: json['event_name'],
      eventDescription: json['event_description'],
      eventImage: json['event_image'],
      eventLocationLongitude: json['event_location_longitude'],
      eventLocationLatitude: json['event_location_latitude'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      isAllDay: json['is_all_day'],
    );
  }

  @override
  List<Object?> get props => [id, eventName, startTime, endTime, isAllDay];
}
