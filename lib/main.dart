import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/truck_tracking_map.dart';
import 'services/dummy_gps_service.dart';
import 'splash.dart'; // Import the splash screen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DummyGPSService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwachTNiti App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
      home: SplashScreen(), // Set SplashScreen as the initial widget
      debugShowCheckedModeBanner: false,
    );
  }
}
