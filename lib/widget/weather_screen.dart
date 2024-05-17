// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/utils/cubit.dart/cubit.dart';
import 'package:weatherapp/utils/cubit.dart/states.dart';
import 'package:weatherapp/widget/myList.dart';

class WeatherScreen extends StatelessWidget {
  var searchController = TextEditingController();
  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (BuildContext context, Object? state) {
        if (state is SearchWeatherErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'flutterfonts',
                    ),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
      builder: (BuildContext context, state) {
        var cubit = WeatherCubit.get(context);
        return Scaffold(
            body: ConditionalBuilder(
          condition: cubit.currentWeatherModel != null,
          builder: (BuildContext context) {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter:
                            ColorFilter.mode(Colors.black38, BlendMode.darken),
                        image: AssetImage(
                          'assets/images/cloud-in-blue-sky.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.only(top: 50, left: 20, right: 20),
                          child: TextField(
                            controller: searchController,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              cubit.getSearchWeatherForecast(
                                  city: searchController.text);
                              cubit.getSearchFiveDaysDailyForecastData(
                                  city: searchController.text);
                            },
                            decoration: InputDecoration(
                              suffix: Icon(
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
                        ),
                        Align(
                          alignment: Alignment(0.0, 1.0),
                          child: SizedBox(
                            height: 10,
                            width: 10,
                            child: OverflowBox(
                              minWidth: 0.0,
                              maxWidth: MediaQuery.of(context).size.width,
                              minHeight: 0.0,
                              maxHeight:
                                  (MediaQuery.of(context).size.height / 3.4),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          //TODO
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 15, left: 20, right: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    '${cubit.currentWeatherModel!.name}'
                                                        .toUpperCase(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                          color: Colors.black45,
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'flutterfonts',
                                                        ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    DateFormat()
                                                        .add_MMMMEEEEd()
                                                        .format(DateTime.now()),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                          color: Colors.black45,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'flutterfonts',
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 50),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      '${cubit.currentWeatherModel!.weather![0].description}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'flutterfonts',
                                                          ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      '${(cubit.currentWeatherModel!.main!.temp! - 273.15).round().toString()}\u2103',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2!
                                                          .copyWith(
                                                              color: Colors
                                                                  .black45,
                                                              fontFamily:
                                                                  'flutterfonts'),
                                                    ),
                                                    Text(
                                                      'min: ${(cubit.currentWeatherModel!.main!.tempMin! - 273.15).round().toString()}\u2103 / max: ${(cubit.currentWeatherModel!.main!.tempMax! - 273.15).round().toString()}\u2103',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'flutterfonts',
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(right: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 120,
                                                      height: 120,
                                                      child: LottieBuilder.asset(
                                                          "assets/anims/cloudy.json"),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'wind ${cubit.currentWeatherModel!.wind!.speed} m/s',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                              color: Colors
                                                                  .black45,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'flutterfonts',
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          padding: EdgeInsets.only(top: 120),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'forcast next 5 days '.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black45,
                                            ),
                                      ),
                                      Icon(
                                        Icons.next_plan_outlined,
                                        color: Colors.black45,
                                      ),
                                    ],
                                  ),
                                ),
                                MyList(
                                  cubit: cubit,
                                ),

                                // MyChart(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          fallback: (BuildContext context) => Center(
            child: CircularProgressIndicator(),
          ),
        ));
      },
    );
  }
}
