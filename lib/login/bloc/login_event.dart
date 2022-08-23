part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUserNameChanged extends LoginEvent {
  final String email;
  const LoginUserNameChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  const LoginPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();

  @override
  List<Object> get props => [];
}

