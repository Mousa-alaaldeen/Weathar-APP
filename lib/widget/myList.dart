// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/utils/cubit.dart/cubit.dart';

class MyList extends StatelessWidget {
  const MyList({
    super.key,
    required this.cubit,
  });

  final WeatherCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemCount: cubit.dailyForecastData.length,
        itemBuilder: (context, index) {
          final item = cubit.dailyForecastData[index];
          String dayName =
              DateFormat('EEEE').format(DateTime.parse(item.dtTxt));
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontFamily: 'flutterfonts',
                        ),
                  ),
                  Text(
                    '${(item.main.temp - 273.15).round().toString()}\u2103',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontFamily: 'flutterfonts',
                        ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: LottieBuilder.asset("assets/anims/cloudy.json"),
                  ),
                  Text(
                    '${item.weather[0].description}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.black45,
                          fontFamily: 'flutterfonts',
                          fontSize: 12,
                        ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Icon(Icons.water_drop,
                                  color: Colors.blue, size: 16),
                              Text(
                                '${item.main.humidity}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.black45,
                                      fontFamily: 'flutterfonts',
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Icon(Icons.compress,
                                  color: Colors.grey, size: 16),
                              Text(
                                '${item.main.pressure} hPa',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.black45,
                                      fontFamily: 'flutterfonts',
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.air, color: Colors.green, size: 16),
                          Text(
                            '${item.wind.speed} m/s',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.black45,
                                      fontFamily: 'flutterfonts',
                                      fontSize: 12,
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
        },
      ),
    );
  }
}
