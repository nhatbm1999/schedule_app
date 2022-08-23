// ignore_for_file: prefer_if_null_operators

import 'package:equatable/equatable.dart';
import 'package:schedule_app/schedule/model/event_model.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.avatar,
    required this.phone,
    required this.userName,
    required this.listEvents,
  });
  final String id;
  final String email;
  final String userName;
  final String avatar;
  final String phone;
  final List<EventModel> listEvents;

  factory User.fromJson(Map<String, dynamic> json) {
    final events = <EventModel>[];
    if(json.containsKey('registeredEvents')) {
      final registeredEventJsons = json['registeredEvents'];
      for(final registeredEventJson in registeredEventJsons) {
        events.add(EventModel.fromJson(registeredEventJson));
      }
    }
    return User(
      id: json['_id'],
      email: json['email'],
      phone: json['phone'],
      userName: json['username'],
      avatar: json['avatar'],
      listEvents: events
    );
  }
  @override
  List<Object?> get props => [email, id, avatar, phone];
}
