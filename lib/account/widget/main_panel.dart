import 'package:flutter/material.dart';
import 'package:schedule_app/account/bloc/account_bloc.dart';
import 'package:schedule_app/account/widget/account_item.dart';
import 'package:schedule_app/common/theme/common_theme.dart';

class MainPanelWidget extends StatelessWidget {
  const MainPanelWidget({Key? key, required this.accountState}) : super(key: key);

  final AccountState accountState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          AccountItem(
            hasNotice: true,
            listItem: accountState.user!.listEvents.length,
            onTap: () {},
            icon: Icon(
              Icons.calendar_today,
              size: 50,
              color: CommonTheme().mainColor,
            ),
            itemContent: Text('Registered Event',
                style: Theme.of(context).textTheme.bodyText2),
          ),
          AccountItem(
            hasNotice: false,
            onTap: () {},
            icon: Icon(Icons.lock_reset,
                size: 50, color: CommonTheme().mainColor),
            itemContent: Text('Change Password',
                style: Theme.of(context).textTheme.bodyText2),
          ),
          AccountItem(
            hasNotice: true,
            onTap: () {},
            icon: Icon(Icons.notifications,
                size: 50, color: CommonTheme().mainColor),
            itemContent: Text('Notifications',
                style: Theme.of(context).textTheme.bodyText2),
          ),
          AccountItem(
            hasNotice: false,
            onTap: () {},
            icon: Icon(Icons.logout, size: 50, color: CommonTheme().mainColor),
            itemContent:
                Text('Log Out', style: Theme.of(context).textTheme.bodyText2),
          )
        ],
      ),
    );
  }
}
