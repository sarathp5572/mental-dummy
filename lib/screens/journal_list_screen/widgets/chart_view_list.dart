import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mentalhelth/screens/journal_list_screen/provider/journal_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartViewList extends StatelessWidget {
  const ChartViewList({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.05,
        ),
        SizedBox(
          height: size.height * 0.5,
          width: double.infinity,
          child: const ChartCircularWidget(),
        ),
      ],
    );
  }
}

//chart widget
class ChartCircularWidget extends StatefulWidget {
  const ChartCircularWidget({Key? key}) : super(key: key);
  @override
  ChartCircularWidgetState createState() => ChartCircularWidgetState();
}



class ChartCircularWidgetState extends State<ChartCircularWidget> {
  late TooltipBehavior tooltip;
  List<ChartData> data = []; // Initialize with an empty list
  final Map<String, Color> colorMap = {
    'Optimal': Colors.green,
    'Stressful': Colors.yellow,
    'Passive': Colors.blue,
    'Destructive': Colors.red,
  };
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    tooltip = TooltipBehavior(enable: true);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _fetchData();
    });
  }

  Future<void> _fetchData() async {
    final journalListProvider = Provider.of<JournalListProvider>(context, listen: false);
    await journalListProvider.fetchJournalChartView();

    if (journalListProvider.journalChartViewModel != null) {
      setState(() {
        data = [
          ChartData(
            'Optimal',
            journalListProvider.journalChartViewModel?.chartpercentage!.optimalPercent?.toInt() ?? 0,
          ),
          ChartData(
            'Stressful',
            journalListProvider.journalChartViewModel?.chartpercentage!.stressfullPercent?.toInt() ?? 0,
          ),
          ChartData(
            'Passive',
            journalListProvider.journalChartViewModel?.chartpercentage!.passivePercent?.toInt() ?? 0,
          ),
          ChartData(
            'Destructive',
            journalListProvider.journalChartViewModel?.chartpercentage!.destructivePercent?.toInt() ?? 0,
          ),
        ].where((dataPoint) => dataPoint.y > 0).toList(); // Filter out zero values
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<JournalListProvider>(
      builder: (context, journalListProvider, _) {
        logger.w("data ${journalListProvider.journalChartViewModel?.chartpercentage!.optimalPercent?.toDouble()}");
        if (data.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Replace with your desired color
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: CustomLegend(
                  data: [
                    ChartData('Optimal',
                        journalListProvider.journalChartViewModel?.chartpercentage!.optimalPercent?.toInt() ?? 0),
                    ChartData('Stressful',
                        journalListProvider.journalChartViewModel?.chartpercentage!.stressfullPercent?.toInt() ?? 0),
                    ChartData('Passive',
                        journalListProvider.journalChartViewModel?.chartpercentage!.passivePercent?.toInt() ?? 0),
                    ChartData('Destructive',
                        journalListProvider.journalChartViewModel?.chartpercentage!.destructivePercent?.toInt() ?? 0),
                  ],
                  colorMap: colorMap,
                ),
              ),
              Container(
                height:  size.height * 0.37,
             //   color: Colors.indigo,
                child: SfCircularChart(
                  legend: const Legend(
                    isVisible: false, // Hide default legend
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: data,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      pointColorMapper: (ChartData data, _) {
                        return colorMap[data.x] ?? Colors.grey;
                      },
                      cornerStyle: CornerStyle.bothFlat,
                      strokeColor: Colors.white,
                      strokeWidth: 2.0,
                      explode: true,
                      legendIconType: LegendIconType.circle,
                      explodeAll: true,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelIntersectAction: LabelIntersectAction.shift,
                        labelAlignment: ChartDataLabelAlignment.auto,
                        useSeriesColor: true,
                        labelPosition: ChartDataLabelPosition.inside,
                        builder: (dynamic data, ChartPoint<dynamic> point, ChartSeries<dynamic, dynamic> series, int pointIndex, int seriesIndex) {
                          final value = point.y; // Format to two decimal places
                          return Text(
                            '$value%',
                            style: const TextStyle(
                              color: Colors.white, // Change this to your desired color
                              fontSize: 20, // Optional: Adjust font size
                              fontWeight: FontWeight.bold, // Optional: Adjust font weight
                            ),
                          );
                        },
                      ),
                      enableTooltip: true,

                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomLegend extends StatelessWidget {
  final List<ChartData> data;
  final Map<String, Color> colorMap;

  const CustomLegend({
    Key? key,
    required this.data,
    required this.colorMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.map((ChartData dataPoint) {
        final color = colorMap[dataPoint.x] ?? Colors.grey;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                dataPoint.x,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}





class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}


