import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/models/coored.dart';
import 'package:weatherapp/models/current_five_model.dart';

import 'package:weatherapp/utils/cubit.dart/states.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/utils/location_service.dart';
import 'package:weatherapp/utils/weather_services.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(WeatherInitialState());

  static WeatherCubit get(context) => BlocProvider.of(context);
  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = "62f69baf1df7e8cd48c807f7b4b627b7";
  List<CurrentWeatharModel> currentWeatherModel = [];
  List<WeatherList> fiveDayDataModel = [];

  void getWeatherForecast({
    required double latitude,
    required double longitude,
  }) async {
    emit(GetWeatherLodingState());
    HttpHelper.getData(
      url: '$baseUrl/weather?lat=$latitude&lon=$longitude&appid=$apiKey',
    ).then((response) {
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        print(decodedData);
        var weatherData = CurrentWeatharModel.fromJson(decodedData);
        currentWeatherModel.add(weatherData);
        print('temp_max: ${weatherData.name}');
        emit(GetWeatherSuccessState());
      } else {
        // Handle error when the status code is not 200
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetWeatherErrorState(error));
      // Handle error when an error occurs during the request
    });
  }

  void getFiveDaysThreeHoursForcastData({
    required double latitude,
    required double longitude,
  }) async {
    emit(GetWeatherLodingState());
    HttpHelper.getData(
      url:
          'https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=62f69baf1df7e8cd48c807f7b4b627b7',
    ).then((response) {
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        var weatherData = FiveDayModel.fromJson(decodedData);

        // Access the list of weather forecasts and add them to fiveDayDataModel
        for (var e in weatherData.list!) {
          fiveDayDataModel.add(e);
        }

        print('Weather Data: ${fiveDayDataModel}');
        emit(GetWeatherSuccessState());
      } else {
        // Handle error when the status code is not 200
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetWeatherErrorState(error));
      // Handle error when an error occurs during the request
    });
  }

  Future<void> fetchLocationAndWeather() async {
    try {
      final locationService = LocationService();
      final locationData = await locationService.getLocation();
      getWeatherForecast(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );
    } catch (e) {
      emit(GetWeatherErrorState(e.toString()));
    }
  }
}
