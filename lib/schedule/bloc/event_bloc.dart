import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:schedule_app/common/widget/status.dart';
import 'package:schedule_app/schedule/model/event_model.dart';
import 'package:schedule_app/schedule/repository/event_repository.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc({required this.eventRepository}) : super(const EventState()) {
    on<FetchEvent>(_onFetchEvent);
  }

  final EventRepository eventRepository;

  FutureOr<void> _onFetchEvent(
      FetchEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(status: LoadStatus.initial));
    try {
      final listEvent = await eventRepository.getEvents();
      return emit(state.copyWith(
        events: listEvent,
        status: LoadStatus.success,
      ));
    } catch (e) {
      return emit(state.copyWith(
          errorMessage: e.toString(), status: LoadStatus.failure));
    }
  }
}
