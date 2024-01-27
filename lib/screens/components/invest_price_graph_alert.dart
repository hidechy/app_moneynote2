import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../utilities/utilities.dart';

class InvestPriceGraphAlert extends ConsumerStatefulWidget {
  const InvestPriceGraphAlert({super.key, required this.investName, this.data, this.mindate});

  final String investName;
  final Map<String, int>? data;
  final DateTime? mindate;

  @override
  ConsumerState<InvestPriceGraphAlert> createState() => _InvestPriceGraphAlertState();
}

class _InvestPriceGraphAlertState extends ConsumerState<InvestPriceGraphAlert> {
  final Utility _utility = Utility();

  final ScrollController _controller = ScrollController();

  LineChartData graphData = LineChartData();

  List<FlSpot> flspots = [];

  ///
  @override
  Widget build(BuildContext context) {
    final kakesuu = (widget.data != null) ? (widget.data!.length / 10) : 1;

    setChartData();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: SizedBox(
            width: context.screenSize.width * kakesuu,
            height: context.screenSize.height - 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: context.screenSize.width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text('投資商品金額一覧'), Text(widget.investName)],
                ),
                Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
                const SizedBox(height: 20),
                Expanded(child: LineChart(graphData)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.withOpacity(0.3)),
                      onPressed: () => _controller.jumpTo(_controller.position.maxScrollExtent),
                      child: const Text('jump'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.withOpacity(0.3)),
                      onPressed: () => _controller.jumpTo(_controller.position.minScrollExtent),
                      child: const Text('back'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  void setChartData() {
    final list = <int>[];

    final dateMap = <double, String>{};

    flspots = [];

    if (widget.data != null) {
      var i = 0;
      widget.data!.forEach((key, value) {
        flspots.add(FlSpot((i + 1).toDouble(), value.toDouble()));
        list.add(value);
        dateMap[(i + 1).toDouble()] = key;
        i++;
      });

      final minValue = list.reduce(min);
      final maxValue = list.reduce(max);

      const warisuu = 50000;

      final graphMin = ((minValue / warisuu).floor()) * warisuu;
      final graphMax = ((maxValue / warisuu).ceil()) * warisuu;

      graphData = LineChartData(
        minX: 1,
        maxX: flspots.length.toDouble(),
        //
        minY: graphMin.toDouble(),
        maxY: graphMax.toDouble(),

        ///
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.white.withOpacity(0.3),
            getTooltipItems: _utility.getGraphToolTip,
          ),
        ),

        ///
        gridData: _utility.getFlGridData(),

        ///
        titlesData: FlTitlesData(
          //-------------------------// 上部の目盛り
          topTitles: const AxisTitles(),
          //-------------------------// 上部の目盛り

          //-------------------------// 下部の目盛り
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                final exDate = (dateMap[value] == null) ? <String>[] : dateMap[value]!.split('-');

                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: (dateMap[value] == null)
                      ? const Text('')
                      : DefaultTextStyle(
                          style: const TextStyle(fontSize: 10),
                          child: Column(children: [Text(exDate[0]), Text('${exDate[1]}-${exDate[2]}')]),
                        ),
                );
              },
            ),
          ),
          //-------------------------// 下部の目盛り

          //-------------------------// 左側の目盛り
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 70,
              getTitlesWidget: (value, meta) => Text(value.toInt().toString(), style: const TextStyle(fontSize: 10)),
            ),
          ),
          //-------------------------// 左側の目盛り

          //-------------------------// 右側の目盛り

          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 70,
              getTitlesWidget: (value, meta) => Text(value.toInt().toString(), style: const TextStyle(fontSize: 10)),
            ),
          ),

          //-------------------------// 右側の目盛り
        ),

        ///
        lineBarsData: [
          LineChartBarData(spots: flspots, barWidth: 3, isStrokeCapRound: true, color: Colors.yellowAccent),
        ],
      );
    }
  }
}
