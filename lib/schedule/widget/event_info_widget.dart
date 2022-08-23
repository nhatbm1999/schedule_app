import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/schedule/model/event_model.dart';

class EventInfoWidget extends StatelessWidget {
  const EventInfoWidget({
    Key? key,
    required this.eventModel,
    required this.addressName,
  }) : super(key: key);

  final EventModel eventModel;
  final String addressName;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat.yMMMMEEEEd();
    final DateFormat hourFormat = DateFormat.Hm();
    final String formattedEventStartDate =
        dateFormat.format(eventModel.startTime);
    final String formattedEventEndDate = dateFormat.format(eventModel.endTime);
    final String formattedEventStartHour =
        hourFormat.format(eventModel.startTime);
    final String formattedEventEndHour = hourFormat.format(eventModel.endTime);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event details',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: CommonTheme().mainColor,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.calendar_month,
                size: 32,
                color: CommonTheme().grayTextColor,
              ),
              const SizedBox(
                width: 10,
              ),
              formattedEventStartDate == formattedEventEndDate
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedEventStartDate,
                          style: TextStyle(
                              color: CommonTheme().mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          formattedEventStartHour +
                              ' ' +
                              '-' +
                              ' ' +
                              formattedEventEndHour,
                          style: TextStyle(color: CommonTheme().mainColor),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Text(formattedEventStartDate +
                            '' +
                            '-' +
                            '' +
                            formattedEventEndDate),
                      ],
                    ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                size: 35,
                color: CommonTheme().grayTextColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  addressName,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: CommonTheme().primaryColor,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'About the event',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: CommonTheme().mainColor,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Icon(
                Icons.description,
                size: 35,
                color: CommonTheme().grayTextColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: eventModel.eventDescription != null
                    ? Text(
                        eventModel.eventDescription!,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: CommonTheme().primaryColor, fontSize: 12),
                      )
                    : Text(
                        'No description for this event',
                        style: TextStyle(
                          color: CommonTheme().mainColor,
                        ),
                      ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
