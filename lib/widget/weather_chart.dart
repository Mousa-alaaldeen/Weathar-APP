// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:weather_app/controller/HomeController.dart';

// import '../model/five_days_data.dart';

// class WeatherChart extends StatelessWidget {
//   const WeatherChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: size.width,
//       height: size.height * .2,
//       child: Card(
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           series: <ChartSeries<FiveDayData, String>>[
//             SplineSeries<FiveDayData, String>(
//               dataSource: controller.fiveDaysData,
//               xValueMapper: (FiveDayData f, _) => f.dateTime,
//               yValueMapper: (FiveDayData f, _) => f.temp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
