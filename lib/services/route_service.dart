// lib/services/route_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RouteService {
  final String apiKey = '5b3ce3597851110001cf6248cce625ef06d24b18a1397926cd63dc34';
  final String baseUrl = 'https://api.openrouteservice.org/v2/directions/driving-car';

  Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final url = Uri.parse('$baseUrl?api_key=$apiKey&start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List coordinates = data['features'][0]['geometry']['coordinates'];

      // Convert coordinates to LatLng
      return coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
    } else {
      throw Exception('Failed to load route');
    }
  }
}
