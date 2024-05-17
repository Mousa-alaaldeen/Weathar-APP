// ignore_for_file: prefer_const_constructors

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/utils/cubit.dart/cubit.dart';
import 'package:weatherapp/utils/cubit.dart/states.dart';
import 'package:weatherapp/widget/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..fetchLocationAndWeather(),
      child: BlocConsumer<WeatherCubit, WeatherStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WeatherScreen(),
        ),
      ),
    );
  }
}
