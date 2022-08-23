import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:schedule_app/schedule/model/event_model.dart';

class FullMapPage extends StatefulWidget {
  const FullMapPage({Key? key, required this.eventModel,}) : super(key: key);

  final EventModel eventModel;

  static Route route(EventModel eventModel) {
    return MaterialPageRoute(builder: (_) => FullMapPage(eventModel: eventModel,));
  }

  @override
  State<FullMapPage> createState() => _FullMapPageState();
}

class _FullMapPageState extends State<FullMapPage> {
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
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.eventModel.eventLocationLatitude, widget.eventModel.eventLocationLongitude), zoom: 14),
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
