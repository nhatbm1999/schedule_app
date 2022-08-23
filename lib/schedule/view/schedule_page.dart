import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:schedule_app/authentication/bloc/authentication_bloc.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/common/widget/network_error.dart';
import 'package:schedule_app/common/widget/status.dart';
import 'package:schedule_app/schedule/bloc/event_bloc.dart';
import 'package:schedule_app/schedule/model/event_model.dart';
import 'package:schedule_app/schedule/view/schedule_detail_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  static const path = '/schedule';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const SchedulePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => context.read<EventBloc>().add(FetchEvent()),
          child: BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              switch (state.status) {
                case LoadStatus.initial:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case LoadStatus.failure:
                  return NetworkErrorWidget(
                      retry: () => context.read<EventBloc>().add(FetchEvent()));
                case LoadStatus.success:
                  List<EventModel> _getDataSource() {
                    final List<EventModel> events = <EventModel>[];
                    for (var event in state.events!) {
                      events.add(EventModel(
                          id: event.id,
                          eventName: event.eventName,
                          eventDescription: event.eventDescription,
                          eventImage: event.eventImage,
                          eventLocationLatitude: event.eventLocationLatitude,
                          eventLocationLongitude: event.eventLocationLongitude,
                          startTime: event.startTime,
                          endTime: event.endTime,
                          isAllDay: event.isAllDay));
                    }
                    return events;
                  }
                  return SfCalendar(
                    view: CalendarView.month,
                    firstDayOfWeek: 1,
                    initialSelectedDate: DateTime.now(),
                    showNavigationArrow: true,
                    onTap: (CalendarTapDetails details) async {
                      String addressName;
                      // List<Placemark> placemarks =
                      //     await placemarkFromCoordinates(
                      //         details.appointments![0].eventLocationLatitude, details.appointments![0].eventLocationLongitude);
                      // Placemark place = placemarks[1];
                      // addressName =
                      //     '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}';

                      details.appointments!.isNotEmpty &&
                              details.targetElement ==
                                  CalendarElement.appointment
                          ? Navigator.of(context).push(ScheduleDetailPage.route(
                              details.appointments![0]))
                          : null;
                    },
                    todayHighlightColor: CommonTheme().mainColor,
                    dataSource: MeetingDataSource(_getDataSource()),
                    monthViewSettings: const MonthViewSettings(
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.indicator,
                        showAgenda: true,
                        dayFormat: 'EEE'),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<EventModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
