import 'package:flutter/material.dart';
import 'package:weather_app_with_bloc/bloc/weather_bloc_bloc.dart';
import 'package:weather_app_with_bloc/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          tabBarTheme: const TabBarTheme(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.amber,
              indicatorSize: TabBarIndicatorSize.label),
          bottomAppBarTheme:
              const BottomAppBarTheme(shape: CircularNotchedRectangle()),
          cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              headlineLarge: TextStyle(color: Colors.white)),
          appBarTheme:
              const AppBarTheme(color: Colors.transparent, centerTitle: true),
          useMaterial3: true,
        ),
        home: FutureBuilder(
            future: _determinePosition(),
            builder: (context, snap) {
              if (snap.hasData) {
                return BlocProvider<WeatherBlocBloc>(
                  create: (context) => WeatherBlocBloc()
                    ..add(FetchWeather(snap.data as Position)),
                  child: HomeScreen(),
                );
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }));
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Konum bulunamadı");
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Konum izni reddedildi");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error("Kalıcı reddedildi");
  }

  return await Geolocator.getCurrentPosition();
}
