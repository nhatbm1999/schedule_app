import 'package:dio/dio.dart';
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
}
