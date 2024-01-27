import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/screens/components/invest_price_graph_alert.dart';
import 'package:money_note/screens/components/parts/money_dialog.dart';

import '../../extensions/extensions.dart';
import '../../state/holidays/holidays_notifier.dart';
import '../../utilities/utilities.dart';

class InvestPriceListAlert extends ConsumerStatefulWidget {
  const InvestPriceListAlert({super.key, required this.investName, this.data, this.mindate});

  final String investName;
  final Map<String, int>? data;
  final DateTime? mindate;

  @override
  ConsumerState<InvestPriceListAlert> createState() => _InvestPriceListAlertState();
}

class _InvestPriceListAlertState extends ConsumerState<InvestPriceListAlert> {
  final Utility _utility = Utility();

  Map<String, String> _holidayMap = {};

  ///
  @override
  Widget build(BuildContext context) {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [const Text('投資商品金額一覧'), Text(widget.investName)],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    GestureDetector(
                      onTap: () {
                        MoneyDialog(
                          context: context,
                          widget: InvestPriceGraphAlert(
                              investName: widget.investName, data: widget.data, mindate: widget.mindate),
                        );
                      },
                      child: const Icon(Icons.show_chart),
                    ),
                  ],
                ),
              ),
              Expanded(child: _displayInvestPriceList()),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInvestPriceList() {
    final list = <Widget>[];

    final holidayState = ref.watch(holidayProvider);

    if (holidayState.holidayMap.value != null) {
      _holidayMap = holidayState.holidayMap.value!;
    }

    widget.data?.forEach((key, value) {
      if (widget.mindate != null && value != 0) {
        if (DateTime.parse('$key 00:00:00').difference(widget.mindate!).inDays >= 0) {
          list.add(Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
              color: _utility.getYoubiColor(
                date: DateTime.parse('$key 00:00:00').yyyymmdd,
                youbiStr: DateTime.parse('$key 00:00:00').youbiStr,
                holidayMap: _holidayMap,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(key), Text(value.toString().toCurrency())],
            ),
          ));
        }
      }
    });

    return SingleChildScrollView(child: Column(children: list));
  }
}
