abstract class WeatherStates {}

class WeatherInitialState extends WeatherStates {}

class GetWeatherLodingState extends WeatherStates {}

class GetWeatherSuccessState extends WeatherStates {}

class GetWeatherErrorState extends WeatherStates {
  final String error;
  GetWeatherErrorState(this.error);
}
