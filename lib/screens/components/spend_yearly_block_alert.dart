import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/spend_time_place.dart';
import '../../extensions/extensions.dart';
import '../../utilities/functions.dart';

class SpendYearlyBlockAlert extends ConsumerStatefulWidget {
  const SpendYearlyBlockAlert({super.key, required this.date, required this.isar});

  final DateTime date;
  final Isar isar;

  @override
  ConsumerState<SpendYearlyBlockAlert> createState() => _SpendYearlyBlockAlertState();
}

class _SpendYearlyBlockAlertState extends ConsumerState<SpendYearlyBlockAlert> {
  // ignore: use_late_for_private_fields_and_variables
  List<SpendTimePlace>? _yearlySpendTimePlaceList = [];

  Map<String, Map<String, int>> _yearlySpendSumMap = {};

  ///
  void _init() {
    _makeYearlySpendSumMap();
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
                children: [const Text('年間使用金額比較'), Text(widget.date.yyyy)],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: _displayYearlySpendSumMap()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _makeYearlySpendSumMap() async {
    final spendTimePlacesCollection = widget.isar.spendTimePlaces;

    final getSpendTimePlaces =
        await spendTimePlacesCollection.filter().dateStartsWith(widget.date.yyyy).sortByDate().findAll();

    if (mounted) {
      setState(() {
        _yearlySpendTimePlaceList = getSpendTimePlaces;

        if (_yearlySpendTimePlaceList != null) {
          _yearlySpendSumMap = makeYearlySpendItemSumMap(spendTimePlaceList: _yearlySpendTimePlaceList!);
        }
      });
    }
  }

  ///
  Widget _displayYearlySpendSumMap() {
    final list = <Widget>[];

    final oneWidth = context.screenSize.width / 6;

    _yearlySpendSumMap.forEach((key, value) {
      var sum = 0;
      value.forEach((key2, value2) {
        sum += value2;
      });

      list.add(Container(
        width: context.screenSize.width,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.indigo.withOpacity(0.8), Colors.transparent], stops: const [0.7, 1]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(key),
            Text(sum.toString().toCurrency()),
          ],
        ),
      ));

      final list2 = <Widget>[];

      for (var i = 1; i <= 12; i++) {
        list2.add(
          Container(
            width: oneWidth,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.4))),
            child: Stack(
              children: [
                Text(
                  i.toString().padLeft(2, '0'),
                  style: const TextStyle(color: Colors.grey),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    (value[i.toString().padLeft(2, '0')] != null)
                        ? value[i.toString().padLeft(2, '0')].toString().toCurrency()
                        : '0',
                  ),
                ),
              ],
            ),
          ),
        );
      }

      list
        ..add(Wrap(children: list2))
        ..add(const SizedBox(height: 20));
    });

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list),
    );
  }
}
