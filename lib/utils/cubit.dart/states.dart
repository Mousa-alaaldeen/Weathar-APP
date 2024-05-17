abstract class WeatherStates {}

class WeatherInitialState extends WeatherStates {}

class GetWeatherLodingState extends WeatherStates {}

class GetWeatherSuccessState extends WeatherStates {}

class GetWeatherErrorState extends WeatherStates {
  final String error;
  GetWeatherErrorState(this.error);
}

class GetFiveDaysThreeHoursForecastDataLodingState extends WeatherStates {}

class GetFiveDaysThreeHoursForecastDataSuccessState extends WeatherStates {}

class GetFiveDaysThreeHoursForecastDataErrorState extends WeatherStates {
  final String error;
  GetFiveDaysThreeHoursForecastDataErrorState(this.error);
}

class SearchWeatherLodingState extends WeatherStates {}

class SearchWeatherSuccessState extends WeatherStates {}

class SearchWeatherErrorState extends WeatherStates {
  final String error;
  SearchWeatherErrorState(this.error);
}
