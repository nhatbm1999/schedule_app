import 'package:flutter/material.dart';
import 'package:schedule_app/account/bloc/account_bloc.dart';
import 'package:schedule_app/account/view/register_events_page.dart';
import 'package:schedule_app/account/widget/account_item.dart';
import 'package:schedule_app/authentication/bloc/authentication_bloc.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPanelWidget extends StatelessWidget {
  const MainPanelWidget({Key? key, required this.accountState})
      : super(key: key);

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
            onTap: () => Navigator.of(context)
                .push(RegisterEventPage.route(accountState.user!)),
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
            onTap: () {
              showDialog(
                  context: context,
                  builder: ((context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        title: Assets.image.iconLogout
                            .image(width: 70, height: 70),
                        content: Text('Do you want to log out ?'),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  context
                                      .read<AuthenticationBloc>()
                                      .add(AuthenticationLogoutRequested());
                                },
                                icon: const Icon(Icons.check),
                                label: const Text(
                                  'OK',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.redAccent),
                              ),
                            ],
                          ),
                        ],
                      )));
            },
            icon: Icon(Icons.logout, size: 50, color: CommonTheme().mainColor),
            itemContent:
                Text('Log Out', style: Theme.of(context).textTheme.bodyText2),
          )
        ],
      ),
    );
  }
}
