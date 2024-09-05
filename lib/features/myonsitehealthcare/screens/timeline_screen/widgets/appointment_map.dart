import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controllers/timeline_screen_controller.dart';

class IPAppointmentMap extends StatelessWidget {
  final String bookId;
  const IPAppointmentMap({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimelineScreenController(bookId));
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 300,
        child: Obx(() => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: controller.currentUserLocation.value,
            zoom: 14,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          polylines: Set<Polyline>.of(controller.polylines.values), // Show route
        )),
      ),
    );
  }
}
