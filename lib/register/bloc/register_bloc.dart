import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:schedule_app/authentication/model/user.dart';
import 'package:schedule_app/login/model/email.dart';
import 'package:schedule_app/login/model/password.dart';
import 'package:schedule_app/register/model/name.dart';
import 'package:schedule_app/register/model/phone_number.dart';
import 'package:schedule_app/register/repository/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.registerRepository}) : super(const RegisterState()) {
    on<RegisterNameChanged>(_onRegisterNameChanged);
    on<RegisterEmailChanged>(_onRegisterEmailChanged);
    on<RegisterPasswordChanged>(_onRegisterPasswordChanged);
    on<RegisterPasswordConfirmChanged>(_onRegisterPasswordConfirmChanged);
    on<RegisterPhoneNumberChanged>(_onRegisterPhoneNumberChanged);
    on<RegisterSubmit>(_onRegisterSubmit);
  }
  final RegisterRepository registerRepository;

  FutureOr<void> _onRegisterNameChanged(
    RegisterNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = Name.dirty(event.name);
    emit(state.copyWith(
      name: username,
      status: Formz.validate([state.password, username, state.email]),
    ));
  }

  FutureOr<void> _onRegisterEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email,
        status: Formz.validate([state.password, email, state.name])));
  }

  FutureOr<void> _onRegisterPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password,
        status: Formz.validate([password, state.email, state.name])));
  }

  void _onRegisterPasswordConfirmChanged(
    RegisterPasswordConfirmChanged event,
    Emitter<RegisterState> emit,
  ) {
    return emit(state.copyWith(
      confirm: event.confirm,
      status: event.input == event.confirm
          ? FormzStatus.valid
          : FormzStatus.invalid,
    ));
  }

  void _onRegisterPhoneNumberChanged(
    RegisterPhoneNumberChanged event,
    Emitter<RegisterState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    return emit(state.copyWith(
        phoneNumber: phoneNumber,
        status: phoneNumber.valid ? FormzStatus.valid : FormzStatus.invalid));
  }

  FutureOr<void> _onRegisterSubmit(
    RegisterSubmit event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final userRegister = await registerRepository.register(
        email: state.email.value, username: state.name.value, password: state.password.value, phone: state.phoneNumber.value);
      return emit(state.copyWith(
        user: userRegister,
        status: FormzStatus.submissionSuccess
      ));
    } catch(error) {
      return emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: error.toString()
      ));
    }
  }
}
