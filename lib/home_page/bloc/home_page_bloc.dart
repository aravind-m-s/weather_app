import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/home_page/model/weather_model.dart';
import 'package:weather_app/home_page/services/geolocator_service.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<GetWeatherData>((event, emit) async {
      emit(
        HomePageState(
          weather: state.weather,
          isLoading: true,
        ),
      );
      try {
        final position = await getPosition();
        if (position.runtimeType == String) {
          return emit(HomePageState(weather: state.weather, isError: true));
        }

        // ignore: inference_failure_on_function_invocation
        await Dio(BaseOptions()).get(
          'http://api.weatherapi.com/v1/current.json',
          queryParameters: {
            'key': '4a22dddfd2ce4e85971144640230505',
            'q': '${position.latitude},${position.longitude}'
          },
        ).then((value) {
          final data = value.data;
          if (data.containsKey('error') == true) {
            emit(HomePageState(weather: state.weather, isError: true));
          } else {
            emit(
              HomePageState(
                weather: WeatherModel.fromJson(data),
              ),
            );
          }
        });
      } catch (e) {
        emit(
          HomePageState(
            weather: state.weather,
            isError: true,
          ),
        );
      }
    });
  }
}
