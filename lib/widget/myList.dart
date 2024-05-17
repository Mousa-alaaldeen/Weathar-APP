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
      height: 150,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: cubit.dailyForecastData.length,
        itemBuilder: (context, index) {
          final item = cubit.dailyForecastData[index];
          String dayName =
              DateFormat('EEEE').format(DateTime.parse(item.dtTxt));
          return Container(
            height: 150,
            width: 140,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayName,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: 'flutterfonts',
                          ),
                    ),
                    Text(
                      '${(item.main.temp - 273.15).round().toString()}\u2103',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: 'flutterfonts',
                          ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: LottieBuilder.asset("assets/anims/cloudy.json"),
                    ),
                    Text(
                      '${item.weather[0].description}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.black45,
                            fontFamily: 'flutterfonts',
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => VerticalDivider(
          color: Colors.transparent,
          width: 5,
        ),
      ),
    );
  }
}
