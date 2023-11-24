// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_with_bloc/data/my_data.dart';


part "weather_bloc_event.dart";
part "weather_bloc_state.dart";

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async{
      emit(WeatherBlocLoading());
        try {
          WeatherFactory wf = WeatherFactory(API_KEY, language: Language.TURKISH);
          
          Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude,
            );
            print(weather);
             emit(WeatherBlocSuccess(weather));
        } catch (e) {
            emit(WeatherBlocFailure());
        }
    });
  }
}