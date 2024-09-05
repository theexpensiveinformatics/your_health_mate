import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../../../data/service/remainder/notfication_service.dart';

class TimelineScreenController extends GetxController {
  final String bookId;

  TimelineScreenController(this.bookId);

  // Observable variables to hold appointment details
  final isLoading = false.obs;
  final currentStep = ''.obs;
  final donatorName = ''.obs;
  final phlebotomistName = ''.obs;
  final currentUserLocation = const LatLng(37.7749, -122.4194).obs; // Initial dummy location
  final Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;
  final estimatedTime = 'Calculating...'.obs;

  Timer? _locationUpdateTimer;
  static const _updateInterval = Duration(seconds: 5); // Update every 5 seconds

  @override
  void onInit() {
    super.onInit();
    _listenToAppointmentUpdates(); // Start listening to Firestore updates
    _startLocationUpdates(); // Start location updates
  }

  @override
  void onClose() {
    _locationUpdateTimer?.cancel(); // Cancel timer on close
    super.onClose();
  }

  void _startLocationUpdates() async {

    // Update user location and fetch new route every 5 seconds
    _locationUpdateTimer = Timer.periodic(_updateInterval, (timer) async {
      await _updateUserLocation();
      await _fetchRoute();
    });

  }

  Future<void> _updateUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentUserLocation.value = LatLng(position.latitude, position.longitude);
  }

  Future<void> _fetchRoute() async {
    final phlebotomistLocation = await _getPhlebotomistLocation();
    if (phlebotomistLocation == null) return;

    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${currentUserLocation.value.latitude},${currentUserLocation.value.longitude}&destination=${phlebotomistLocation.latitude},${phlebotomistLocation.longitude}&key=AIzaSyCGkKWEylc61Pz7Dj-vesTbpp7jq4zbj8I';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      // Update polyline
      List<LatLng> points = _decodePolyline(data['routes'][0]['overview_polyline']['points']);
      _updatePolyline(points);

      // Update estimated time
      estimatedTime.value = data['routes'][0]['legs'][0]['duration']['text'];
    } else {
      print('Error fetching route: ${response.statusCode}');
    }
  }

  Future<LatLng?> _getPhlebotomistLocation() async {
    final snapshot = await FirebaseFirestore.instance.collection('appointment').doc(bookId).get();
    if (snapshot.exists) {
      GeoPoint geoPoint = snapshot.data()?['phlebotomist_location'];
      return LatLng(geoPoint.latitude, geoPoint.longitude);
    }
    return null;
  }

  void _updatePolyline(List<LatLng> points) {
    final PolylineId id = PolylineId('route');
    final Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: points.map((point) => LatLng(point.latitude, point.longitude)).toList(),
      width: 5,
    );

    polylines[id] = polyline;
  }

  void _listenToAppointmentUpdates() {
    FirebaseFirestore.instance.collection('appointment').doc(bookId).snapshots().listen((event) {
      if (event.exists) {
        donatorName.value = event.data()?['donator_name'] ?? '';
        phlebotomistName.value = event.data()?['phlebotomist_name'] ?? '';

        final newStatus = event.data()?['status'] ?? 'No';

        String message;
        switch (newStatus) {
          case 0:
            message = 'Requested';
            break;
          case 1:
            message = 'On the way';
            break;
          case 2:
            message = 'Arrived';
            break;
          case 3:
            message = 'Complete';
            break;
          default:
            message = 'Status updated';
            break;
        }
        // Check if status has changed
        if (currentStep.value != newStatus) {
          currentStep.value = newStatus; // Update status
          _showNotification(
            "Status Updated",
            newStatus == '0'
                ? "Appointment booked"
                : newStatus == '1'
                ? "On the way"
                : newStatus == '2'
                ? "Arrived"
                : newStatus == '3'
                ? "Complete"
                : "Status updated",
          );
        }
      }
    });
  }

  String getNotificationString(double newStatus)
  {
    switch(newStatus){
      case 0:
        return'Requested';

      case 1:
        return 'On the way';

      case 2:
        return 'Arrived';

      case 3:
        return 'Complete';

      default:
        return 'Status updated';

    }
    return "Updated";
  }
  // Method to show local notification
  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', 'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return poly;
  }
}

