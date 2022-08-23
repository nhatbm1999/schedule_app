import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app/account/bloc/account_bloc.dart';
import 'package:schedule_app/account/widget/account_item.dart';
import 'package:schedule_app/account/widget/main_panel.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key, required this.accountState}) : super(key: key);

  final AccountState accountState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          accountState.avatar.isNotEmpty && accountState.avatarImage != null
              ? CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(
                    File(accountState.avatar),
                  ),
                )
              : accountState.avatar.isEmpty &&
                      accountState.user!.avatar.isNotEmpty
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          CachedNetworkImageProvider(accountState.user!.avatar),
                    )
                  : accountState.avatar.isEmpty &&
                          accountState.avatarImage == null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundColor: CommonTheme().placeHolderColor,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: CommonTheme().grayTextColor,
                          ))
                      : Container(),
          Positioned(
            bottom: 5,
            right: 5,
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.white,
              child: InkWell(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg', 'jpeg'],
                  );
                  if (result != null) {
                    context.read<AccountBloc>().add(
                          ChangeAvatarEvent(
                              avatarImageName: result.files.single.name,
                              avatarImage: File(result.files.single.path!),
                              avatarPath: result.files.single.path!),
                        );
                    context.read<AccountBloc>().add(UploadUserAvatar(
                          avatarImage: File(result.files.single.path!),
                          avatarImageName: result.files.single.name,
                          avatarPath: result.files.single.path!,
                          userId: accountState.user!.id,
                        ));
                  }
                },
                child: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: CommonTheme().mainColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
