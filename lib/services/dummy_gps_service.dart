// lib/services/dummy_gps_service.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'route_service.dart';

class DummyGPSService with ChangeNotifier {
  final RouteService _routeService = RouteService();

  List<LatLng> routePoints = [];
  List<LatLng> redMarkers = [
    LatLng(18.99058485496607, 73.12761658344387),
    LatLng(18.989894680486813, 73.1280030010906),
    LatLng(18.98924295032495, 73.12651132608953),
    LatLng(18.98782657815781, 73.12842694322426),
    LatLng(18.990821815174478, 73.12651351616678), // New marker
    LatLng(18.986971070409933, 73.12954636693456), // New marker
    LatLng(18.98971947003831, 73.1268953454372),  // New node added
  ];
  List<bool> redMarkerStates = List.filled(7, false); // Updated to match the number of markers

  int _currentRouteIndex = 0;
  double _animationProgress = 0.0;
  late Timer _timer;

  LatLng get currentTruckPosition {
    if (routePoints.isEmpty || _currentRouteIndex >= routePoints.length - 1) {
      return LatLng(0, 0); // Default position if route is not loaded
    }

    // Interpolated position between current point and next point
    final LatLng start = routePoints[_currentRouteIndex];
    final LatLng end = routePoints[_currentRouteIndex + 1];

    double lat = start.latitude + (_animationProgress * (end.latitude - start.latitude));
    double lng = start.longitude + (_animationProgress * (end.longitude - start.longitude));

    return LatLng(lat, lng);
  }

  DummyGPSService() {
    _loadRoute();
  }

  Future<void> _loadRoute() async {
    final startLocation = LatLng(18.990919104909626, 73.126364268048);
    final endLocation = LatLng(18.986514830005767, 73.1299479191979);
    routePoints = await _routeService.getRoute(startLocation, endLocation);

    _startMovingTruck();
  }

  void _startMovingTruck() {
    // Shorter timer interval for smoother animation
    _timer = Timer.periodic(Duration(milliseconds: 100), _moveTruck);
  }

  void _moveTruck(Timer timer) {
    if (routePoints.isEmpty || _currentRouteIndex >= routePoints.length - 1) {
      _timer.cancel();
      return;
    }

    // Increase the animation progress
    _animationProgress += 0.008; // Adjust this value for smoother or slower animation

    if (_animationProgress >= 1.0) {
      // Move to the next point
      _currentRouteIndex++;
      _animationProgress = 0.0;
    }

    _checkPassedNodes();
    notifyListeners(); // Notify listeners to update the UI
  }

  void _checkPassedNodes() {
    final currentPosition = currentTruckPosition;

    for (int i = 0; i < redMarkers.length; i++) {
      if (!redMarkerStates[i] && _isNearby(currentPosition, redMarkers[i])) {
        redMarkerStates[i] = true; // Mark the node as passed
      }
    }
  }

  bool _isNearby(LatLng position1, LatLng position2) {
    final distance = Distance().as(LengthUnit.Meter, position1, position2);
    return distance < 10.0; // Define your threshold for "passing" a node
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
