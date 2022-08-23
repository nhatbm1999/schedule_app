part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterNameChanged extends RegisterEvent {
  const RegisterNameChanged({required this.name});
  final String name;
}

class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged({required this.email});
  final String email;

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent{
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterPasswordConfirmChanged extends RegisterEvent {
  const RegisterPasswordConfirmChanged({required this.input, required this.confirm});

  final String input;
  final String confirm;

  @override
  List<Object> get props => [confirm];
}

class RegisterPhoneNumberChanged extends RegisterEvent {
  const RegisterPhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}


class RegisterSubmit extends RegisterEvent {
  @override
  List<Object> get props => [];
}

class EnableButton extends RegisterEvent {
  const EnableButton({required this.enable});
  final bool enable;

  @override
  List<Object> get props => [enable];
}

class LoadingIndicatorEvent extends RegisterEvent {
  const LoadingIndicatorEvent();

  @override
  List<Object> get props => [];
}

