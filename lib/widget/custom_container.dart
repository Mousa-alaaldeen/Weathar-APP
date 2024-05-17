import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/utils/cubit.dart/cubit.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.searchController,
    required this.cubit,
  }) : super(key: key);

  final TextEditingController searchController;
  final WeatherCubit cubit;

  @override
  Widget build(BuildContext context) {
    String backgroundImage = "assets/images/cloud-in-blue-sky.jpg";

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              style: TextStyle(
                color: Colors.white,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                cubit.getSearchWeatherForecast(city: searchController.text);
                cubit.getSearchFiveDaysDailyForecastData(
                    city: searchController.text);
              },
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Search'.toUpperCase(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '${cubit.currentWeatherModel!.name}'.toUpperCase(),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'flutterfonts',
                        ),
                  ),
                ),
                Center(
                  child: Text(
                    DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'flutterfonts',
                        ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      '${cubit.currentWeatherModel!.weather![0].description}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'flutterfonts',
                          ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${(cubit.currentWeatherModel!.main!.temp! - 273.15).round().toString()}\u2103',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.white, fontFamily: 'flutterfonts'),
                    ),
                    Text(
                      'min: ${(cubit.currentWeatherModel!.main!.tempMin! - 273.15).round().toString()}\u2103 / max: ${(cubit.currentWeatherModel!.main!.tempMax! - 273.15).round().toString()}\u2103',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'flutterfonts',
                          ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: LottieBuilder.asset("assets/anims/cloudy.json"),
                    ),
                    Text(
                      'wind ${cubit.currentWeatherModel!.wind!.speed} m/s',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'flutterfonts',
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
