import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/spend_time_place.dart';
import '../../extensions/extensions.dart';
import '../../state/holidays/holidays_notifier.dart';
import '../../utilities/functions.dart';
import '../../utilities/utilities.dart';

class SpendMonthlyListAlert extends ConsumerStatefulWidget {
  const SpendMonthlyListAlert({super.key, required this.date, required this.isar});

  final DateTime date;
  final Isar isar;

  @override
  ConsumerState<SpendMonthlyListAlert> createState() => _SpendMonthlyListAlertState();
}

class _SpendMonthlyListAlertState extends ConsumerState<SpendMonthlyListAlert> {
  final Utility _utility = Utility();

  // ignore: use_late_for_private_fields_and_variables
  List<SpendTimePlace>? _monthlySpendTimePlaceList = [];

  final Map<String, Map<String, int>> _monthlySpendTimePlaceMap = {};

  Map<String, String> _holidayMap = {};

  ///
  void _init() {
    _makeMonthlySpendTimePlaceList();
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
                children: [const Text('月間使用用途履歴'), Container()],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: _displayMonthlySpendItemPlaceList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _makeMonthlySpendTimePlaceList() async {
    final spendTimePlacesCollection = widget.isar.spendTimePlaces;

    final getSpendTimePlaces =
        await spendTimePlacesCollection.filter().dateStartsWith(widget.date.yyyymm).sortByDate().findAll();

    if (mounted) {
      setState(() {
        _monthlySpendTimePlaceList = getSpendTimePlaces;

        final map = <String, List<SpendTimePlace>>{};
        _monthlySpendTimePlaceList!.forEach((element) => map[element.date] = []);
        _monthlySpendTimePlaceList!.forEach((element) => map[element.date]?.add(element));

        map.forEach((key, value) {
          _monthlySpendTimePlaceMap[key] = makeMonthlySpendItemSumMap(spendTimePlaceList: value);
        });
      });
    }
  }

  ///
  Widget _displayMonthlySpendItemPlaceList() {
    final list = <Widget>[];

    final holidayState = ref.watch(holidayProvider);

    if (holidayState.holidayMap.value != null) {
      _holidayMap = holidayState.holidayMap.value!;
    }

    _monthlySpendTimePlaceMap.forEach((key, value) {
      var sum = 0;
      value.forEach((key2, value2) => sum += value2);

      final list2 = <Widget>[];
      value.forEach((key2, value2) {
        list2.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(key2), Text(value2.toString().toCurrency())],
          ),
        ));
      });

      list.add(Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          color: _utility.getYoubiColor(
            date: DateTime.parse('$key 00:00:00').yyyymmdd,
            youbiStr: DateTime.parse('$key 00:00:00').youbiStr,
            holidayMap: _holidayMap,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(key), Text(sum.toString().toCurrency())],
            ),
            const SizedBox(height: 10),
            Column(children: list2),
          ],
        ),
      ));
    });

    return SingleChildScrollView(child: Column(children: list));
  }
}
