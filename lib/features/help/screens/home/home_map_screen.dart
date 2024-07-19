import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class YHMHomeMapScreen extends StatelessWidget {
  final List<Map<String, dynamic>> servicesWithDistance;

  YHMHomeMapScreen({required this.servicesWithDistance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Services on Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(servicesWithDistance[0]['data']['mapLat'], servicesWithDistance[0]['data']['mapLng']),
          zoom: 12,
        ),
        markers: servicesWithDistance.map((service) {
          return Marker(
            markerId: MarkerId(service['data']['liveServiceID']),
            position: LatLng(service['data']['mapLat'], service['data']['mapLng']),
            infoWindow: InfoWindow(
              title: service['data']['liveServiceName'],
              snippet: '${service['data']['serviceProviderName']} - ${service['distance'] / 1000} kms',
            ),
          );
        }).toSet(),
      ),
    );
  }
}


class CustomMarker extends StatelessWidget {
  final String serviceName;

  CustomMarker({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        serviceName,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

