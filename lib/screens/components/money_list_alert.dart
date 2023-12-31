import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../collections/money.dart';
import '../../extensions/extensions.dart';

class MoneyListAlert extends StatefulWidget {
  const MoneyListAlert({super.key, required this.date, required this.isar});

  final DateTime date;
  final Isar isar;

  @override
  State<MoneyListAlert> createState() => _MoneyListAlertState();
}

class _MoneyListAlertState extends State<MoneyListAlert> {
  List<Money>? moneyList = [];

  Map<String, Money> dateMoneyMap = {};

  ///
  void _init() {
    _makeMoneyList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    Future(_init);

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: GoogleFonts.kiwiMaru(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('CURRENCY枚数リスト'),
                  Text(widget.date.yyyymm),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: _dispDateMoneyList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _makeMoneyList() async {
    dateMoneyMap = {};

    final moneyCollection = widget.isar.moneys;

    final getMoneys = await moneyCollection.where().sortByDate().findAll();

    setState(() {
      moneyList = getMoneys;

      if (moneyList!.isNotEmpty) {
        moneyList!.forEach((element) {
          dateMoneyMap[element.date] = element;
        });
      }
    });
  }

  ///
  Widget _dispDateMoneyList() {
    final list = <Widget>[
      Row(
        children: [
          Container(
            width: 140,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent.withOpacity(0.2)),
            ),
            margin: const EdgeInsets.all(1),
            padding: const EdgeInsets.all(1),
            child: const Text(''),
          ),
          const SizedBox(width: 10),
          _displayMidashiList(),
        ],
      )
    ];

    dateMoneyMap.forEach((key, value) {
      list.add(Row(
        children: [
          Container(
            width: 140,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            margin: const EdgeInsets.all(1),
            padding: const EdgeInsets.all(1),
            child: Text('$key（${DateTime.parse('$key 00:00:00').youbiStr.substring(0, 3)}）'),
          ),
          const SizedBox(width: 10),
          _displayCurrencyList(value: value),
        ],
      ));
    });

    return SingleChildScrollView(scrollDirection: Axis.horizontal, child: Column(children: list));
  }

  ///
  Widget _displayMidashiList() {
    const width = 70;
    final color = Colors.yellowAccent.withOpacity(0.1);

    return Row(
      children: [
        _displayCurrencyParts(
            value: 10000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 5000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 2000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 1000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 500,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 100,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 50,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 10,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 5,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 1,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
      ],
    );
  }

  ///
  Widget _displayCurrencyList({required Money value}) {
    const width = 70;
    const color = Colors.transparent;

    return Row(
      children: [
        _displayCurrencyParts(
            value: value.yen_10000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_5000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_2000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_1000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_500,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_100,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_50,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_10,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_5,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_1,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
      ],
    );
  }

  ///
  Widget _displayCurrencyParts({
    required int value,
    required double width,
    required Color color,
    required Color borderColor,
    required Alignment alignment,
  }) {
    return Container(
      decoration: BoxDecoration(
//        border: Border.all(color: Colors.white.withOpacity(0.2)),
        border: Border.all(color: borderColor),
        color: color,
      ),
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(1),
      width: width,
      alignment: alignment,
      child: Text(value.toString()),
    );
  }
}
