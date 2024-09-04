// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:easytrax/screens/analytics_page.dart';
import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/home_screen/provider/home_provider.dart';
import 'package:mentalhelth/utils/core/date_time_utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/chart_view_model.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  TooltipBehavior? tooltipBehavior;

  @override
  void initState() {
    tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        return homeProvider.chartViewLoading
            ? Center(
          child: SizedBox(
            height: size.height * 0.2,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: size.height * 0.18,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: size.height * 0.15,
                        width: size.width * 0.05,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const SizedBox(height: 8),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.14,
                        width: size.width * 0.05,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const SizedBox(height: 8),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                        width: size.width * 0.05,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const SizedBox(height: 8),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.15,
                        width: size.width * 0.05,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const SizedBox(height: 8),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.13,
                        width: size.width * 0.05,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const SizedBox(height: 8),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.09,
                        width: size.width * 0.05,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const SizedBox(height: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.04,
                // ),
                SizedBox(
                  height: size.height * 0.02,
                  width: double.infinity,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Card(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const SizedBox(height: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            : homeProvider.chartViewModel == null
            ? SizedBox(
          height: size.height * 0.23,
          width: double.infinity,
          child: Image.asset(
            'assets/gif/home_graf.gif',
            fit: BoxFit.fill,
          ),
        )
            : SizedBox(
          height: size.height * 0.2,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: const CategoryAxis(
              majorGridLines: MajorGridLines(
                width: 0,
              ), //     axisLine: const AxisLine(
              majorTickLines: MajorTickLines(
                width: 0,
                color: Colors.blue,
              ),
            ),
            primaryYAxis: const NumericAxis(
              axisLine: AxisLine(
                width: 2,
                color: Colors.blue,
              ),
              majorTickLines: MajorTickLines(
                width: 0,
                color: Colors.blue,
              ),
              majorGridLines: MajorGridLines(
                width: 0,
                color: Colors.blue,
              ),
              isVisible: false,
              minimum: 0,
              maximum: 6,
            ),
            series: <ColumnSeries<Chart, String>>[
              ColumnSeries<Chart, String>(
                enableTooltip: true,
                color: Colors.blue,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                ),
                width: 0.2,
                spacing: 0.2,
                dataSource: homeProvider.chartViewModel!.chart!,
                xValueMapper: (Chart sales, _) =>
                // sales.dateTime,
                formatDateToString(
                  int.parse(sales.dateTime),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.height * 0.1),
                  topRight: Radius.circular(size.height * 0.1),
                ),
                yValueMapper: (Chart sales, _) => sales.score,
              ),
            ],
          ),
        );
      },
    );
  }
}

// class CustomRoundedBars extends StatelessWidget {
//   final List<dynamic> data;
//   final bool animate;
//
//   CustomRoundedBars(this.data, {this.animate});
//
//   @override
//   Widget build(BuildContext context) {
//     var seriesList = _createSampleData(data);
//
//     return new charts.BarChart(
//       seriesList,
//       animate: animate,
//       barGroupingType: charts.BarGroupingType.grouped,
//       defaultRenderer: new charts.BarRendererConfig(
//           cornerStrategy: const charts.ConstCornerStrategy(30)),
//     );
//   }
//
//   /// Create one series with sample hard coded data.
//   static List<charts.Series<Mileage, String>> _createSampleData(dynamic data) {
//     return [
//       new charts.Series<Mileage, String>(
//         id: 'mileage1',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (Mileage mileage, _) => mileage.day,
//         measureFn: (Mileage mileage, _) => mileage.km,
//         data: data,
//         fillColorFn: (Mileage mileage, _) =>
//             charts.ColorUtil.fromDartColor(Colors.transparent),
//       ),
//       new charts.Series<Mileage, String>(
//         id: 'mileage',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (Mileage mileage, _) => mileage.day,
//         measureFn: (Mileage mileage, _) => mileage.km,
//         data: data,
//       ),
//       new charts.Series<Mileage, String>(
//         id: 'mileage2',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (Mileage mileage, _) => mileage.day,
//         measureFn: (Mileage mileage, _) => mileage.km,
//         data: data,
//         fillColorFn: (Mileage mileage, _) =>
//             charts.ColorUtil.fromDartColor(Colors.transparent),
//       ),
//     ];
//   }
// }
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:easytrax/screens/analytics_page.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mentalhelth/screens/home_screen/provider/home_provider.dart';
// import 'package:mentalhelth/utils/core/date_time_utils.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// import '../model/chart_view_model.dart';
//
// class ChartWidget extends StatelessWidget {
//   const ChartWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Consumer<HomeProvider>(builder: (context, homeProvider, _) {
//       return homeProvider.chartViewLoading
//           ? const Center(
//         child: CircularProgressIndicator(),
//       )
//           : homeProvider.chartViewModel == null
//           ? SizedBox(
//         height: size.height * 0.2,
//         child: const Text(
//           "No Data",
//         ),
//       )
//           : SizedBox(
//         height: size.height * 0.2,
//         // child: SfCartesianChart(
//         //   plotAreaBorderWidth:
//         //       0, // Remove the border around the plot area
//         //   primaryXAxis: DateTimeAxis(
//         //     // labelIntersectAction: AxisLabelIntersectAction.rotate45,
//         //     axisLine: const AxisLine(
//         //       width: 2,
//         //       color: Colors.blue,
//         //     ),
//         //     majorTickLines: const MajorTickLines(
//         //       width: 0,
//         //       color: Colors.blue,
//         //     ),
//         //     majorGridLines: const MajorGridLines(
//         //       width: 0,
//         //       color: Colors.blue,
//         //     ),
//         //     intervalType: DateTimeIntervalType.auto,
//         //     dateFormat: DateFormat.MMMd(),
//         //   ),
//         //   primaryYAxis: const NumericAxis(
//         //     isVisible: false,
//         //     labelIntersectAction:
//         //         AxisLabelIntersectAction.multipleRows,
//         //     majorGridLines: MajorGridLines(
//         //       width: 0,
//         //     ), // Hide y-axis gridlines
//         //   ),
//         //   series: <ColumnSeries<Chart, DateTime>>[
//         //     ColumnSeries<Chart, DateTime>(
//         //       dataLabelSettings: const DataLabelSettings(
//         //         isVisible: true,
//         //       ),
//         //       dataSource:
//         //           homeProvider.chartViewModel!.chart!.length > 6
//         //               ? homeProvider.chartViewModel!.chart!.sublist(
//         //                   0,
//         //                   6,
//         //                 ) // Display only first 6 elements
//         //               : homeProvider.chartViewModel!.chart!,
//         //       // borderWidth: 10,
//         //       isTrackVisible: false,
//         //       opacity: 0.9,
//         //       width: 0.9,
//         //       spacing: 0,
//         //       borderRadius: const BorderRadius.only(
//         //         topLeft: Radius.circular(10),
//         //         topRight: Radius.circular(10),
//         //       ),
//         //       xValueMapper: (Chart sales, _) =>
//         //           formatDateToDateTime(int.parse(sales.dateTime!)),
//         //       yValueMapper: (Chart sales, _) => sales.score ?? 0,
//         //     ),
//         //   ],
//         // ),
//
//         child: SfCartesianChart(
//           plotAreaBorderWidth: 0,
//           primaryXAxis: DateTimeAxis(
//             dateFormat: DateFormat.MMMd(),
//           ),
//           primaryYAxis: const NumericAxis(
//             isVisible: false,
//             minimum: 0,
//             maximum: 10,
//           ),
//           series: <ColumnSeries<Chart, DateTime>>[
//             ColumnSeries<Chart, DateTime>(
//               enableTooltip: true,
//               color: Colors.blue,
//               dataLabelSettings: const DataLabelSettings(
//                 isVisible: true,
//               ),
//               width: 0.9,
//               spacing: 0.2,
//               dataSource: homeProvider.chartViewModel!.chart!,
//               xValueMapper: (Chart sales, _) => formatDateToDateTime(
//                 int.parse(
//                   sales.dateTime!,
//                 ),
//               ),
//               yValueMapper: (Chart sales, _) => sales.score ?? 0,
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
//
// // class CustomRoundedBars extends StatelessWidget {
// //   final List<dynamic> data;
// //   final bool animate;
// //
// //   CustomRoundedBars(this.data, {this.animate});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     var seriesList = _createSampleData(data);
// //
// //     return new charts.BarChart(
// //       seriesList,
// //       animate: animate,
// //       barGroupingType: charts.BarGroupingType.grouped,
// //       defaultRenderer: new charts.BarRendererConfig(
// //           cornerStrategy: const charts.ConstCornerStrategy(30)),
// //     );
// //   }
// //
// //   /// Create one series with sample hard coded data.
// //   static List<charts.Series<Mileage, String>> _createSampleData(dynamic data) {
// //     return [
// //       new charts.Series<Mileage, String>(
// //         id: 'mileage1',
// //         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
// //         domainFn: (Mileage mileage, _) => mileage.day,
// //         measureFn: (Mileage mileage, _) => mileage.km,
// //         data: data,
// //         fillColorFn: (Mileage mileage, _) =>
// //             charts.ColorUtil.fromDartColor(Colors.transparent),
// //       ),
// //       new charts.Series<Mileage, String>(
// //         id: 'mileage',
// //         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
// //         domainFn: (Mileage mileage, _) => mileage.day,
// //         measureFn: (Mileage mileage, _) => mileage.km,
// //         data: data,
// //       ),
// //       new charts.Series<Mileage, String>(
// //         id: 'mileage2',
// //         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
// //         domainFn: (Mileage mileage, _) => mileage.day,
// //         measureFn: (Mileage mileage, _) => mileage.km,
// //         data: data,
// //         fillColorFn: (Mileage mileage, _) =>
// //             charts.ColorUtil.fromDartColor(Colors.transparent),
// //       ),
// //     ];
// //   }
// // }