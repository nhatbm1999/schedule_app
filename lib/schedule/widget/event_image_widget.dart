import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app/schedule/model/event_model.dart';

class EventImageWidget extends StatelessWidget {
  const EventImageWidget({Key? key, required this.eventModel})
      : super(key: key);

  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height / 3,
          child: CachedNetworkImage(
            imageUrl: eventModel.eventImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: size.width,
            height: size.height / 15,
            color: Colors.black.withOpacity(0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(eventModel.eventName, style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        )
      ],
    );
  }
}
