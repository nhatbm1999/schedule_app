import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:schedule_app/account/bloc/account_bloc.dart';
import 'package:schedule_app/account/repository/account_repository.dart';
import 'package:schedule_app/account/view/account_page.dart';
import 'package:schedule_app/authentication/bloc/authentication_bloc.dart';
import 'package:schedule_app/schedule/bloc/event_bloc.dart';
import 'package:schedule_app/schedule/repository/event_repository.dart';
import 'package:schedule_app/schedule/view/schedule_page.dart';
import 'package:schedule_app/settings/view/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const path = '/home';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController? pageController;

  List<Widget> pages = [
    BlocProvider(
      create: (context) => EventBloc(
          eventRepository: EventRepository(httpClient: context.read<Dio>()))..add(FetchEvent()),
      child: const SchedulePage(),
    ),
    BlocProvider(
      create: (context) => AccountBloc(
        accountRepository: AccountRepository(httpClient: context.read<Dio>())
      )..add(GetUserInfo(userId: context.read<AuthenticationBloc>().state.user!.id)),
      child: const AccountPage(),
    ),
    const SettingPage(),
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.date_range_outlined),
              title: const Text('Schedule'),
              selectedColor: Colors.orangeAccent,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Account'),
              selectedColor: Colors.blueAccent,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Settings'),
              selectedColor: Colors.teal,
            ),
          ],
        ),
        body: Center(
          child: pages.elementAt(_currentIndex),
        ));
  }
}
