import 'package:flutter/material.dart';
import 'package:schedule_app/account/bloc/account_bloc.dart';
import 'package:schedule_app/account/widget/avatar.dart';
import 'package:schedule_app/account/widget/main_panel.dart';
import 'package:schedule_app/account/widget/name_display.dart';
import 'package:schedule_app/authentication/bloc/authentication_bloc.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/common/widget/network_error.dart';
import 'package:schedule_app/common/widget/status.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final AccountRepository storage = AccountRepository();
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        switch (state.getInfoStatus) {
          case LoadStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case LoadStatus.failure:
            return Scaffold(
              body: NetworkErrorWidget(
                  retry: () => context.read<AccountBloc>().add(GetUserInfo(
                      userId:
                          context.read<AuthenticationBloc>().state.user!.id))),
            );
          case LoadStatus.success:
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: CommonTheme().mainColor,
              body: Column(
                children: [
                  SizedBox(
                    height: size.height / 5,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 65),
                          width: size.width,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.white),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                AvatarWidget(accountState: state),
                                const SizedBox(
                                  height: 10,
                                ),
                                NameDisplayWidget(accountState: state,),
                                MainPanelWidget(accountState: state,)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
        }
      },
    );
  }
}
