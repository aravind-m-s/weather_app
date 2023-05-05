// ignore_for_file: avoid_dynamic_calls,

class WeatherModel {
  WeatherModel({
    required this.cityName,
    required this.icon,
    required this.condition,
    required this.temp,
    required this.wind,
    required this.humidity,
    required this.windDir,
  });

  factory WeatherModel.fromJson(dynamic json) {
    return WeatherModel(
      cityName: json['location']['name'],
      icon: json['current']['condition']['icon'],
      condition: json['current']['condition']['text'],
      temp: json['current']['temp_c'],
      wind: json['current']['wind_kph'],
      humidity: json['current']['humidity'],
      windDir: json['current']['wind_dir'],
    );
  }

  dynamic cityName;
  dynamic icon;
  dynamic condition;
  dynamic temp;
  dynamic wind;
  dynamic humidity;
  dynamic windDir;
}
