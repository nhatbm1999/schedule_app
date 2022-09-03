import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:schedule_app/authentication/model/user.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/schedule/view/schedule_detail_page.dart';

class RegisterEventPage extends StatelessWidget {
  const RegisterEventPage({Key? key, required this.user}) : super(key: key);

  final User user;

  static PageRoute route(User user) {
    return MaterialPageRoute(
        builder: (_) => RegisterEventPage(
              user: user,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonTheme().mainColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            'Registered events',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: CommonTheme().mainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      user.listEvents.isEmpty
                          ? Center(
                              child: Text(
                                "You haven't registered any event!",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                              ),
                            )
                          : ListView.builder(
                              itemCount: user.listEvents.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                String addressName;
                                return InkWell(
                                  onTap: () async {
                                    List<Placemark> placemarks =
                                        await placemarkFromCoordinates(
                                            user.listEvents[index]
                                                .eventLocationLatitude,
                                            user.listEvents[index]
                                                .eventLocationLongitude);
                                    Placemark place = placemarks[1];
                                    addressName =
                                        '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}';
                                    Navigator.of(context).push(
                                        ScheduleDetailPage.route(
                                            user.listEvents[index],
                                            addressName,
                                            user));
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 3.5),
                                        child: Material(
                                          elevation: 10,
                                          child: Container(
                                            color: Colors.white,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: user
                                                      .listEvents[index]
                                                      .eventImage,
                                                  width: 130,
                                                  height: 110,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Visibility(
                                                            visible: user
                                                                    .listEvents[
                                                                        index]
                                                                    .endTime
                                                                    .isBefore(
                                                                        DateTime
                                                                            .now())
                                                                ? true
                                                                : false,
                                                            child: Tooltip(
                                                              message:
                                                                  'This event ended!',
                                                              child: Icon(
                                                                Icons.error,
                                                                size: 15,
                                                                color: CommonTheme()
                                                                    .errorColor,
                                                              ),
                                                              triggerMode:
                                                                  TooltipTriggerMode
                                                                      .tap,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            DateFormat(
                                                                    'dd.MM.yyyy')
                                                                .format(user
                                                                    .listEvents[
                                                                        index]
                                                                    .startTime),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    color: CommonTheme()
                                                                        .mainColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          Text(
                                                            DateFormat.Hm().format(user
                                                                    .listEvents[
                                                                        index]
                                                                    .startTime) +
                                                                '-' +
                                                                DateFormat.Hm()
                                                                    .format(user
                                                                        .listEvents[
                                                                            index]
                                                                        .endTime),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption,
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          user.listEvents[index]
                                                              .eventName,
                                                          maxLines: 2,
                                                          textAlign:
                                                              TextAlign.center,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .subtitle1
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
