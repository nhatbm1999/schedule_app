part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.user,
    this.errorMessage = '',
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final User? user;
  final String errorMessage;

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  List<Object> get props => [
    email,
    password,
    status,
    errorMessage,
  ];
}

