import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/account/repository/account_repository.dart';
import 'package:schedule_app/authentication/model/user.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/common/widget/network_error.dart';
import 'package:schedule_app/common/widget/status.dart';
import 'package:schedule_app/gen/assets.gen.dart';
import 'package:schedule_app/schedule/bloc/event_bloc.dart';
import 'package:schedule_app/schedule/model/event_model.dart';
import 'package:schedule_app/schedule/repository/event_repository.dart';
import 'package:schedule_app/schedule/widget/event_image_widget.dart';
import 'package:schedule_app/schedule/widget/event_info_widget.dart';
import 'package:schedule_app/schedule/widget/event_location_widget.dart';

class ScheduleDetailPage extends StatelessWidget {
  const ScheduleDetailPage({
    Key? key,
    required this.event,
    required this.addressName,
    required this.user,
  }) : super(key: key);

  final EventModel event;
  final String addressName;
  final User user;

  static Route route(EventModel event, String addressName, User user) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) {
          return EventBloc(
            eventRepository: EventRepository(
              httpClient: context.read<Dio>(),
            ),
            accountRepository: AccountRepository(
              httpClient: context.read<Dio>(),
            ),
          )..add(
              FetchEvent(userId: user.id),
            );
        },
        child: ScheduleDetailPage(
          addressName: addressName,
          event: event,
          user: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        switch (state.status) {
          case LoadStatus.initial:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case LoadStatus.failure:
            return NetworkErrorWidget(
              retry: () => context.read<EventBloc>().add(
                    FetchEvent(
                      userId: user.id,
                    ),
                  ),
            );
          case LoadStatus.success:
            for (var eventId in state.user!.listEvents) {
              if (eventId.id == event.id) {
                context
                    .read<EventBloc>()
                    .add(CheckRegisterEvent(isRegistered: true));
                break;
              }
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leadingWidth: 12, // <-- Use this
                centerTitle: false,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: CommonTheme().mainColor,
                  ),
                ),
                title: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    'Go Back',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        color: CommonTheme().mainColor, fontSize: 17),
                  ),
                ),
                actions: [
                  event.endTime.isAfter(DateTime.now())
                      ? IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                    ),
                                    title: state.isRegistered == false
                                        ? Assets.image.iconRegister
                                            .image(width: 70, height: 70)
                                        : Assets.image.iconUnregister
                                            .image(width: 70, height: 70),
                                    content: state.isRegistered == false
                                        ? Text(
                                            'Do you want to register this event ?',
                                            style: TextStyle(
                                              color: CommonTheme().mainColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : Text(
                                            'Do you want to unregister this event ?',
                                            style: TextStyle(
                                              color: CommonTheme().mainColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              if (state.isRegistered == false) {
                                                context.read<EventBloc>().add(
                                                      RegisteredEvent(
                                                        userId: user.id,
                                                        eventId: event.id,
                                                        eventName:
                                                            event.eventName,
                                                        eventDescription: event
                                                            .eventDescription!,
                                                        eventImage:
                                                            event.eventImage,
                                                        eventLocationLatitude: event
                                                            .eventLocationLatitude,
                                                        eventLocationLongitude:
                                                            event
                                                                .eventLocationLongitude,
                                                        startTime:
                                                            event.startTime,
                                                        endTime: event.endTime,
                                                        isAllDay:
                                                            event.isAllDay,
                                                      ),
                                                    );
                                              } else {
                                                context.read<EventBloc>().add(
                                                    UnregisteredEvent(
                                                        eventId: event.id,
                                                        userId: user.id));
                                              }
                                              context.read<EventBloc>().add(
                                                  FetchEvent(userId: user.id));
                                              Navigator.of(context).pop();
                                            },
                                            icon: const Icon(Icons.check),
                                            label: const Text(
                                              'OK',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                backgroundColor:
                                                    Colors.redAccent),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: state.isRegistered == true
                              ? Icon(
                                  Icons.star,
                                  color: CommonTheme().mainColor,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.star_border,
                                  color: CommonTheme().mainColor,
                                  size: 30,
                                ),
                        )
                      : Tooltip(
                          message: 'This event ended!',
                          child: Icon(
                            Icons.error_sharp,
                            size: 25,
                            color: CommonTheme().errorColor,
                          ),
                          triggerMode: TooltipTriggerMode.tap,
                        ),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: CommonTheme().mainColor,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    EventImageWidget(
                      eventModel: event,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    EventInfoWidget(
                      eventModel: event,
                      addressName: addressName,
                    ),
                    EventLocationWidget(
                      eventModel: event,
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
    //     },
    //   ),
    // );
  }
}
