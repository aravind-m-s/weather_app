part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class GetWeatherData extends HomePageEvent {
  GetWeatherData();
}
