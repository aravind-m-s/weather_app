part of 'home_page_bloc.dart';

class HomePageState {
  HomePageState({this.weather, this.isError = false, this.isLoading = false});
  final WeatherModel? weather;
  final bool isLoading;
  final bool isError;
}

class HomePageInitial extends HomePageState {}
