import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../extensions/extensions.dart';

class InvestPriceListAlert extends StatefulWidget {
  const InvestPriceListAlert({super.key, required this.investName, this.data, this.mindate});

  final String investName;
  final Map<String, int>? data;
  final DateTime? mindate;

  @override
  State<InvestPriceListAlert> createState() => _InvestPriceListAlertState();
}

class _InvestPriceListAlertState extends State<InvestPriceListAlert> {
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

    widget.data?.forEach((key, value) {
      if (widget.mindate != null && value != 0) {
        if (DateTime.parse('$key 00:00:00').difference(widget.mindate!).inDays >= 0) {
          list.add(Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
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
