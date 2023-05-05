import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/home_page/bloc/home_page_bloc.dart';

var _date = DateTime.now();
var _formattedDate = DateFormat('EEEE, d MMM, yyyy').format(_date);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomePageBloc>(context).add(
      GetWeatherData(),
    );
    return Scaffold(
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state.isError || state.weather == null) {
            return const ErrorWidget();
          }
          if (state.isLoading) {
            return const LoadingWidget();
          }
          final weather = state.weather!;
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3FA2FA),
                      Color(0xFF955CD1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weather.cityName.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Height10(),
                    Text(
                      _formattedDate,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https:${weather.icon}',
                          ),
                        ),
                      ),
                    ),
                    Text(
                      weather.condition.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Height10(),
                    Text(
                      '${weather.temp}°',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Humidity',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Height10(),
                      Text(
                        weather.humidity.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Wind Speed',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Height10(),
                      Text(
                        '${weather.wind} km/h',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Wind Direction',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Height10(),
                      Text(
                        weather.windDir.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_rounded,
            color: Colors.white,
            size: 100,
          ),
          const Height10(),
          Text(
            'Something went wrong\nPlease check your location service\nand your network and try again,',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const Height10(),
          SizedBox(
            width: 125,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                'Retry',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.5,
                ),
              ),
              onPressed: () {
                BlocProvider.of<HomePageBloc>(context).add(GetWeatherData());
              },
            ),
          )
        ],
      ),
    );
  }
}

class Height10 extends StatelessWidget {
  const Height10({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}
