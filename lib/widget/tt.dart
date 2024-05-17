// // ignore_for_file: prefer_const_constructors, must_be_immutable, unused_import, implementation_imports, unnecessary_import, deprecated_member_use

// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:cubit_form/cubit_form.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:weatherapp/utils/cubit.dart/cubit.dart';
// import 'package:weatherapp/utils/cubit.dart/states.dart';

// class WeatherScreen extends StatelessWidget {
//   var searchController = TextEditingController();
//   WeatherScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<WeatherCubit, WeatherStates>(
//       listener: (BuildContext context, Object? state) {
//         if (state is SearchWeatherErrorState) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 state.error,
//                 style: Theme.of(context).textTheme.caption!.copyWith(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontFamily: 'flutterfonts',
//                     ),
//               ),
//               backgroundColor: Colors.red,
//               duration: Duration(seconds: 5),
//             ),
//           );
//         }
//       },
//       builder: (BuildContext context, state) {
//         var cubit = WeatherCubit.get(context);
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Weather Forecast'),
//           ),
//           body: BlocBuilder<WeatherCubit, WeatherStates>(
//             builder: (context, state) {
//               if (state is GetFiveDaysThreeHoursForecastDataLodingState) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (state
//                   is GetFiveDaysThreeHoursForecastDataSuccessState) {
//                 return ListView.builder(
//                   itemCount: cubit.forecastData.length,
//                   itemBuilder: (context, index) {
//                     final item = cubit.forecastData[index];
//                     return ListTile(
//                       title: Text('DateTime: ${item.dtTxt}'),
//                       subtitle: Text(
//                           'Temp: ${item.main.temp}, Description: ${item.weather[0].description}'),
//                     );
//                   },
//                 );
//               } else {
//                 return Center(child: Text('Failed to load forecast data'));
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }
