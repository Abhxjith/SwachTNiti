import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/dummy_gps_service.dart';

class TruckTrackingMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gpsService = Provider.of<DummyGPSService>(context);

    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<String>(
          icon: FaIcon(FontAwesomeIcons.bars),
          onSelected: (value) {
            switch (value) {
              case 'Nodes':
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Nodes option selected')),
                );
                break;
              case 'Trucks':
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Trucks option selected')),
                );
                break;
              case 'Logout':
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout option selected')),
                );
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'Nodes',
              child: _buildPopupMenuItem('Nodes', context),
            ),
            PopupMenuItem<String>(
              value: 'Trucks',
              child: _buildPopupMenuItem('Trucks', context),
            ),
            PopupMenuItem<String>(
              value: 'Logout',
              child: _buildPopupMenuItem('Logout', context),
            ),
          ],
          color: Color(0xFFF7F7F7), // Set background color of popup menu
        ),
        title: Text(
          'SwachTNiti',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Color(0xFFF7F7F7),
        elevation: 1.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.bell),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notification icon pressed')),
              );
            },
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: gpsService.routePoints.isNotEmpty
              ? gpsService.currentTruckPosition
              : LatLng(18.9895, 73.1279),
          zoom: 17.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: gpsService.routePoints,
                color: Colors.blue,
                strokeWidth: 7.0,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              if (gpsService.routePoints.isNotEmpty)
                Marker(
                  point: gpsService.currentTruckPosition,
                  width: 70.0,
                  height: 70.0,
                  builder: (ctx) => Image.asset('assets/images/truck.png'),
                ),
              ...gpsService.redMarkers.asMap().entries.map((entry) {
                int index = entry.key;
                LatLng latLng = entry.value;
                bool passed = gpsService.redMarkerStates[index];
                return Marker(
                  point: latLng,
                  width: 30.0,
                  height: 30.0,
                  builder: (ctx) => Container(
                    decoration: BoxDecoration(
                      color: passed ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPopupMenuItem(String title, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
