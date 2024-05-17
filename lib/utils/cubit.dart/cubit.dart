// ignore_for_file: depend_on_referenced_packages, avoid_print, unused_import

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/models/coored.dart';

import 'package:weatherapp/models/tt.dart';

import 'package:weatherapp/utils/cubit.dart/states.dart';

import 'package:weatherapp/utils/location_service.dart';
import 'package:weatherapp/utils/weather_services.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(WeatherInitialState());

  static WeatherCubit get(context) => BlocProvider.of(context);

  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = "62f69baf1df7e8cd48c807f7b4b627b7";
  CurrentWeatharModel? currentWeatherModel;
  List<Tt> forecastData = [];
  List<Tt> dailyForecastData = [];

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
        currentWeatherModel = CurrentWeatharModel.fromJson(decodedData);
        print('temp_max: ${currentWeatherModel!.name}');
        emit(GetWeatherSuccessState());
      } else {
        emit(GetWeatherErrorState('Failed to load weather data'));
      }
    }).catchError((error) {
      emit(GetWeatherErrorState(error.toString()));
    });
  }

  void getFiveDaysDailyForecastData({
    required double latitude,
    required double longitude,
  }) {
    final url = '$baseUrl/forecast?lat=$latitude&lon=$longitude&appid=$apiKey';
    HttpHelper.getData(url: url).then((response) {
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        Map<String, Tt> tempData = {};
        for (var item in decodedData['list']) {
          Tt weatherData = Tt.fromJson(item);
          String date = weatherData.dtTxt.split(' ')[0];
          if (!tempData.containsKey(date)) {
            tempData[date] = weatherData;
          }
        }
        dailyForecastData = tempData.values.toList();

        for (var item in dailyForecastData) {
          print(
              'Date: ${item.dtTxt}, Temp: ${item.main.temp}, Description: ${item.weather[0].description}');
        }

        emit(GetFiveDaysThreeHoursForecastDataSuccessState());
      } else {
        emit(GetWeatherErrorState('Failed to load forecast data'));
      }
    }).catchError((error) {
      emit(GetFiveDaysThreeHoursForecastDataErrorState(error.toString()));
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

      getFiveDaysDailyForecastData(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );
    } catch (e) {
      emit(GetWeatherErrorState(e.toString()));
    }
  }

//////////////search//////////////////////
  void getSearchWeatherForecast({
    required String city,
  }) async {
    emit(SearchWeatherLodingState());
    HttpHelper.getData(
      url: '$baseUrl/weather?q=$city&appid=$apiKey',
    ).then((response) {
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        currentWeatherModel = CurrentWeatharModel.fromJson(decodedData);
        print('temp_max: ${currentWeatherModel!.name}');
        emit(SearchWeatherSuccessState());
      } else {
        emit(SearchWeatherErrorState(response.reasonPhrase.toString()));
      }
    }).catchError((error) {
      emit(SearchWeatherErrorState(error.toString()));
    });
  }

  void getSearchFiveDaysDailyForecastData({
    required String city,
  }) {
    final url = '$baseUrl/forecast?q=$city&appid=$apiKey';
    HttpHelper.getData(url: url).then((response) {
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        Map<String, Tt> tempData = {};
        for (var item in decodedData['list']) {
          Tt weatherData = Tt.fromJson(item);
          String date = weatherData.dtTxt.split(' ')[0];
          if (!tempData.containsKey(date)) {
            tempData[date] = weatherData;
          }
        }
        dailyForecastData = tempData.values.toList();

        for (var item in dailyForecastData) {
          print(
              'Date: ${item.dtTxt}, Temp: ${item.main.temp}, Description: ${item.weather[0].description}');
        }

        emit(GetFiveDaysThreeHoursForecastDataSuccessState());
      } else {
        emit(GetWeatherErrorState('Failed to load forecast data'));
      }
    }).catchError((error) {
      emit(GetFiveDaysThreeHoursForecastDataErrorState(error.toString()));
    });
  }
}
