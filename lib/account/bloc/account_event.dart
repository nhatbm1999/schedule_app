part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class ChangeAvatarEvent extends AccountEvent {
  const ChangeAvatarEvent({
    required this.avatarImage,
    required this.avatarPath,
    required this.avatarImageName,
  });
  final String avatarPath;
  final File avatarImage;
  final String avatarImageName;

  @override
  List<Object> get props => [avatarPath, avatarImage, avatarImageName];
}

class UploadUserAvatar extends AccountEvent {
  const UploadUserAvatar({
    required this.avatarImage,
    required this.avatarImageName,
    required this.avatarPath,
    required this.userId,
  });
  final String avatarPath;
  final String userId;
  final File avatarImage;
  final String avatarImageName;
}

class GetUserInfo extends AccountEvent {
  const GetUserInfo({required this.userId});
  final String userId;
}

class ChangeUserName extends AccountEvent {}

class UserNameChanged extends AccountEvent {
  const UserNameChanged({required this.name});
  final String name;
  @override
  List<Object> get props => [name];
}
