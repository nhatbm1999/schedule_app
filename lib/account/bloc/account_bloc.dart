import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:schedule_app/account/repository/account_repository.dart';
import 'package:schedule_app/authentication/model/user.dart';
import 'package:schedule_app/common/widget/status.dart';
import 'package:schedule_app/register/model/name.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({required this.accountRepository}) : super(const AccountState()) {
    on<AccountEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ChangeAvatarEvent>(_onChangeAvatarEvent);
    on<UploadUserAvatar>(_onUploadUserAvatar);
    on<GetUserInfo>(_onGetUserInfo);
    on<ChangeUserName>(_onChangeUserName);
    on<UserNameChanged>(_onUserNameChanged);
  }

  final AccountRepository accountRepository;

  void _onChangeAvatarEvent(
    ChangeAvatarEvent event,
    Emitter<AccountState> emit,
  ) {
    emit(state.copyWith(
      avatar: event.avatarPath,
      avatarImage: event.avatarImage,
    ));
  }

  FutureOr<void> _onUploadUserAvatar(
    UploadUserAvatar event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final getAvatarImageUrl = await accountRepository.uploadAvatarFile(
          avatarImage: event.avatarImage, fileName: event.avatarImageName);
      final uploadUserAvatar = await accountRepository.uploadAvatarInfo(
          userId: event.userId, avatarImageUrl: getAvatarImageUrl);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onGetUserInfo(
    GetUserInfo event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(getInfoStatus: LoadStatus.initial));
    try {
      final userInfo =
          await accountRepository.getUserInfo(userId: event.userId);
      return emit(state.copyWith(
        getInfoStatus: LoadStatus.success,
        user: userInfo,
      ));
    } catch (e) {
      emit(state.copyWith(getInfoStatus: LoadStatus.failure));
    }
  }

  FutureOr<void> _onChangeUserName(
    ChangeUserName event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final updateUserName = await accountRepository.changeUserName(
          userId: state.user!.id, userName: state.userName.value);
      return emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }

  void _onUserNameChanged(
    UserNameChanged event,
    Emitter<AccountState> emit,
  ) {
    final userName = Name.dirty(event.name);
    return emit(state.copyWith(
      userName: userName
    ));
  }
}
