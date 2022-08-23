part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({
    this.avatar = '',
    this.avatarImage,
    this.avatarUrl = '',
    this.avatarImageName = '',
    this.status = FormzStatus.pure,
    this.errorMessage = '',
    this.user,
    this.getInfoStatus = LoadStatus.initial,
    this.userName = const Name.pure()
  });

  final String avatar;
  final String avatarImageName;
  final File? avatarImage;
  final String avatarUrl;
  final FormzStatus status;
  final LoadStatus getInfoStatus;
  final String errorMessage;
  final User? user;
  final Name userName;

  AccountState copyWith({
    String? avatar,
    File? avatarImage,
    String? avatarUrl,
    String? avatarImageName,
    Name? userName,
    FormzStatus? status,
    String? errorMessage,
    User? user,
    LoadStatus? getInfoStatus,
  }) {
    return AccountState(
      avatar: avatar ?? this.avatar,
      avatarImage: avatarImage ?? this.avatarImage,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarImageName: avatarImageName ?? this.avatarImageName,
      status: status ?? this.status,
      getInfoStatus: getInfoStatus ?? this.getInfoStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      userName: userName ?? this.userName
    );
  }
  
  @override
  List<Object?> get props => [
    avatar,
    avatarImage,
    avatarUrl,
    avatarImageName,
    status,
    getInfoStatus,
    errorMessage,
    user,
    userName,
  ];
}
