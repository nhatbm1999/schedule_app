import 'package:dio/dio.dart';
import 'package:schedule_app/authentication/model/user.dart';
import 'package:schedule_app/schedule/model/event_model.dart';

class EventRepository {
  EventRepository({required this.httpClient});
  final Dio httpClient;

  Future<List<EventModel>> getEvents() async {
    final jsonResponse = await httpClient.get('/event');
    final Map data = jsonResponse.data;
    final List jsons = data["data"];

    return jsons
        .map<EventModel>((json) => EventModel.fromJson(json))
        .toList();
  }

  Future<void> registerEvent({
    required String userId,
    required String eventId,
    required String eventName,
    required String eventDescription,
    required String eventImage,
    required double eventLocationLatitude,
    required double eventLocationLongitude,
    required DateTime startTime,
    required DateTime endTime,
    required bool isAllDay, 
  }) async {
    final jsonResponse = await httpClient.put('/registerEvent?id=$userId', data: {
      '_id': eventId,
      'event_name': eventName,
      'event_description': eventDescription,
      'event_image': eventImage,
      'event_location_latitude': eventLocationLatitude,
      'event_location_longitude': eventLocationLongitude,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'is_all_day': isAllDay,
    });
    return jsonResponse.data;
  }

  Future<void> unregisterEvent({
    required String userId,
    required String eventId,
  }) async {
    final jsonResponse = await httpClient.put('/unregisterEvent?id=$userId', data: {
      '_id': eventId,
    });
    return jsonResponse.data;
  }
  
  Future<User> getUserInfo({
    required String userId,
  }) async {
    final jsonResponse = await httpClient.get('/user?id=$userId');
    return User.fromJson(jsonResponse.data['data']);
  }
}
