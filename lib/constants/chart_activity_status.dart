
import 'package:t2/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t2/constants/constants.dart';

List<Color> gradientColors = [
  secondary,
  primary
];
LineChartData activityData(List<FlSpot> data ,double y) {
  return LineChartData(

    // rangeAnnotations: RangeAnnotations(horizontalRangeAnnotations:[HorizontalRangeAnnotation(y1: 6, y2: y)] ),

    // titlesData: FlTitlesData(
    //   bottomTitles: _bottomTitles,
    //   leftTitles: SideTitles(showTitles: false),
    //   topTitles: SideTitles(showTitles: false),
    //   rightTitles: SideTitles(showTitles: false),
    // ),

    gridData: FlGridData(
      show: false,
      drawVerticalLine: true,
    ),
    titlesData: FlTitlesData(
      show: true,
      //leftTitles: true,
        // bottomTitles: SideTitles(showTitles: true),
        // bottomTitles: SideTitles(showTitles: true),
        // leftTitles: SideTitles(showTitles: false),
        // topTitles: SideTitles(showTitles: false),
        // rightTitles: SideTitles(showTitles: false,getTitlesWidget: GetTitleWidgetFunction(1.2,TitleMeta(appliedInterval: 1.2 ,axisSide: 1.2,formattedValue: 2.1,max: 1.2,min: 2.1,sideTitles: 1.2)),interval:1.1 ,reservedSize: 1.2),
       // rightTitles: AxisTitles(SideTitles(reservedSize: 44, showTitles: false,)),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 0,
    maxX: data.length == 0 ? 24 : data[data.length-1].x +1,
    minY: 0,
    maxY: y,
    lineBarsData: [
      LineChartBarData(
        spots:  data,
        isCurved: false,
        // colors: gradientColors,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          // colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],
  );
}