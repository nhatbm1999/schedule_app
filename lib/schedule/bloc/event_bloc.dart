import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:schedule_app/account/repository/account_repository.dart';
import 'package:schedule_app/authentication/model/user.dart';
import 'package:schedule_app/common/widget/status.dart';
import 'package:schedule_app/schedule/model/event_model.dart';
import 'package:schedule_app/schedule/repository/event_repository.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc({required this.eventRepository, required this.accountRepository})
      : super(EventState()) {
    on<FetchEvent>(_onFetchEvent);
    on<RegisteredEvent>(_onRegisterEvent);
    on<UnregisteredEvent>(_onUnregisterEvent);
    on<FetchUser>(_onFetchUser);
    on<CheckRegisterEvent>(
      (event, emit) {
        return emit(state.copyWith(isRegistered: event.isRegistered));
      },
    );
  }

  final EventRepository eventRepository;
  final AccountRepository accountRepository;

  FutureOr<void> _onFetchEvent(
      FetchEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(status: LoadStatus.initial));
    try {
      final listEvent = await eventRepository.getEvents();
      final userInfo =
          await accountRepository.getUserInfo(userId: event.userId);
      return emit(state.copyWith(
        events: listEvent,
        user: userInfo,
        status: LoadStatus.success,
      ));
    } catch (e) {
      return emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: LoadStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onRegisterEvent(
    RegisteredEvent event,
    Emitter<EventState> emit,
  ) async {
    emit(state.copyWith(registerStatus: FormzStatus.submissionInProgress));
    try {
      await eventRepository.registerEvent(
          userId: event.userId,
          eventId: event.eventId,
          eventName: event.eventName,
          eventDescription: event.eventDescription,
          eventImage: event.eventImage,
          eventLocationLatitude: event.eventLocationLatitude,
          eventLocationLongitude: event.eventLocationLongitude,
          startTime: event.startTime,
          endTime: event.endTime,
          isAllDay: event.isAllDay);
      return emit(state.copyWith(
          registerStatus: FormzStatus.submissionSuccess, isRegistered: true));
    } catch (e) {
      return emit(state.copyWith(
        errorMessage: e.toString(),
        registerStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  FutureOr<void> _onUnregisterEvent(
    UnregisteredEvent event,
    Emitter<EventState> emit,
  ) async {
    try {
      await eventRepository.unregisterEvent(
        userId: event.userId,
        eventId: event.eventId,
      );
      return emit(state.copyWith(
        isRegistered: false,
      ));
    } catch (e) {
      return emit(state.copyWith(
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onFetchUser(
    FetchUser event,
    Emitter<EventState> emit,
  ) async {
    try {
      final userInfo =
          await accountRepository.getUserInfo(userId: event.userId);
      return emit(state.copyWith(
        user: userInfo,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
