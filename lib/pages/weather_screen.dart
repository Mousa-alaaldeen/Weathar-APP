// ignore_for_file: must_be_immutable, deprecated_member_use, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weatherapp/utils/cubit.dart/cubit.dart';
import 'package:weatherapp/utils/cubit.dart/states.dart';
import 'package:weatherapp/widget/custom_container.dart';
import 'package:weatherapp/widget/custom_text.dart';
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
        if (state is GetWeatherErrorState ||
            state is GetFiveDaysThreeHoursForecastDataErrorState ||
            state is SearchWeatherErrorState ||
            state is GetFiveDaysThreeHoursForecastDataErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Please check your internet connection and try again.",
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

        return SafeArea(
          child: Scaffold(
            body: ConditionalBuilder(
                condition: cubit.currentWeatherModel != null,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomContainer(
                            searchController: searchController, cubit: cubit),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(),
                              SizedBox(height: 10),
                              MyList(cubit: cubit),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fallback: (BuildContext context) => Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: Colors.grey,
                        size: 100,
                      ),
                    )),
          ),
        );
      },
    );
  }
}
