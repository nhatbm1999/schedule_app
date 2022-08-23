import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:schedule_app/authentication/model/user.dart';
import 'package:schedule_app/authentication/repository/authentication_repository.dart';
import 'package:schedule_app/login/model/email.dart';
import 'package:schedule_app/login/model/password.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authenticationRepository}) : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginUserNameChanged>(_onLoginUserNameChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
  }

  final AuthenticationRepository authenticationRepository;

  FutureOr<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final user = await authenticationRepository.logIn(
            email: state.email.value, password: state.password.value);
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
        ));
      } catch (error) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: error.toString()));

    }
  }

  void _onLoginUserNameChanged(
    LoginUserNameChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    return emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    ));
  }

  void _onLoginPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit,) {
        final password = Password.dirty(event.password);
        return emit(state.copyWith(
          password: password,
          status: Formz.validate([password, state.email]),
        ));
      }
}

