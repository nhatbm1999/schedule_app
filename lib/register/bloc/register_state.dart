part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.password = const Password.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.user,
    this.enableButton = false,
    this.errorMessage = '',
    this.confirm = '',
  });

  final Name name;
  final Email email;
  final FormzStatus status;
  final Password password;
  final PhoneNumber phoneNumber;
  final User? user;
  final String errorMessage;
  final bool enableButton;
  final String confirm;

  RegisterState copyWith({
    Name? name,
    Email? email,
    FormzStatus? status,
    Password? password,
    User? user,
    bool? enableButton,
    String? errorMessage,
    String? confirm,
    PhoneNumber? phoneNumber,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      enableButton: enableButton ?? this.enableButton,
      confirm: confirm ?? this.confirm,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object> get props => [
    status,
    name,
    email,
    password,
    errorMessage,
    enableButton,
    confirm,
    phoneNumber,
  ];
}

