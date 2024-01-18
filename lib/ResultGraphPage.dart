import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:workapp/editResultPage.dart';

class ResultGraphPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Graph'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditResultPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height /
              2, // Set half of the screen height
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BarChart(
              BarChartData(
                maxY:
                    10, // Set the maximum y-axis value according to your needs
                barGroups: [
                  // Your BarChartGroupData objects here
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(y: 5, colors: [
                        Colors.red,
                      ]),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(y: 3, colors: [
                        Colors.blue,
                      ]),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(y: 7, colors: [
                        Colors.yellow,
                      ]),
                    ],
                  ),
                   BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(y: 7, colors: [
                        Colors.black,
                      ]),
                    ],
                  ),
                   BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(y: 7, colors: [
                        Colors.green,
                      ]),
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(showTitles: true),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTitles: (value) {
                      // Replace with your module names
                      switch (value.toInt()) {
                        case 0:
                          return 'English';
                        case 1:
                          return 'Maths';
                        case 2:
                          return 'Science';
                          case 3:
                          return 'Flutter';
                          case 4:
                          return 'Dart';
                        default:
                          return '';
                      }
                    },
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                groupsSpace: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
