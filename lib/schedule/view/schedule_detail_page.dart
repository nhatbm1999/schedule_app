import 'package:flutter/material.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/schedule/model/event_model.dart';
import 'package:schedule_app/schedule/widget/event_image_widget.dart';
import 'package:schedule_app/schedule/widget/event_info_widget.dart';
import 'package:schedule_app/schedule/widget/event_location_widget.dart';

class ScheduleDetailPage extends StatelessWidget {
  const ScheduleDetailPage(
      {Key? key, required this.event})
      : super(key: key);

  final EventModel event;
  //final String addressName;

  static Route route(EventModel event) {
    return MaterialPageRoute(
        builder: (_) => ScheduleDetailPage(
              event: event,
              //addressName: addressName,
            ));
  }

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: CommonTheme().mainColor, fontSize: 17),
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              
            },
            icon: Icon(Icons.star_border, color: CommonTheme().mainColor, size: 30,),
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
            // EventInfoWidget(
            //   eventModel: event,
            //   //addressName: addressName,
            // ),
            EventLocationWidget(
              eventModel: event,
            ),
          ],
        ),
      ),
    );
  }
}
