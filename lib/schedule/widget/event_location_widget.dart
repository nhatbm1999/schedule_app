import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/schedule/model/event_model.dart';
import 'package:schedule_app/schedule/view/fullmap_page.dart';

class EventLocationWidget extends StatefulWidget {
  const EventLocationWidget({Key? key, required this.eventModel})
      : super(key: key);

  final EventModel eventModel;

  @override
  State<EventLocationWidget> createState() => _EventLocationWidgetState();
}

class _EventLocationWidgetState extends State<EventLocationWidget> {
   Map<MarkerId, Marker> markers = {};
  @override
  void initState() {
    _addMarker(
      LatLng(widget.eventModel.eventLocationLatitude, widget.eventModel.eventLocationLongitude),
      'Origin',
      BitmapDescriptor.defaultMarker,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: CommonTheme().placeHolderColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location on map',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: CommonTheme().mainColor,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width,
              height: size.height / 3,
              child: GoogleMap(
                markers: Set<Marker>.of(markers.values),
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.eventModel.eventLocationLatitude, widget.eventModel.eventLocationLongitude),
                    zoom: 16),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () =>
                        Navigator.of(context).push(FullMapPage.route(widget.eventModel)),
                    child: Text(
                      'See full map',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: CommonTheme().primaryColor,
                          ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
}
