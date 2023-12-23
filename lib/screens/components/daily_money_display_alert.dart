import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/bank_name.dart';
import '../../collections/emoney_name.dart';
import '../../extensions/extensions.dart';

class DailyMoneyDisplayAlert extends ConsumerStatefulWidget {
  const DailyMoneyDisplayAlert({super.key, required this.date, required this.isar});

  final DateTime date;
  final Isar isar;

  @override
  ConsumerState<DailyMoneyDisplayAlert> createState() => _DailyMoneyDisplayAlertState();
}

class _DailyMoneyDisplayAlertState extends ConsumerState<DailyMoneyDisplayAlert> {
  List<BankName>? bankNameList = [];
  List<EmoneyName>? emoneyNameList = [];

  ///
  @override
  Widget build(BuildContext context) {
    _makeBankNameList();
    _makeEmoneyNameList();

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Container(width: context.screenSize.width),

                /////==================================///// BankNames

                FutureBuilder<List<Widget>>(
                  future: _displayBankNames(),
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: context.screenSize.height * 0.2,
                      child: (snapshot.hasData)
                          ? SingleChildScrollView(
                              child: Column(children: snapshot.data!),
                            )
                          : null,
                    );
                  },
                ),

                /////==================================///// BankNames

                /////==================================///// EmoneyNames

                FutureBuilder<List<Widget>>(
                  future: _displayEmoneyNames(),
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: context.screenSize.height * 0.2,
                      child: (snapshot.hasData)
                          ? SingleChildScrollView(
                              child: Column(children: snapshot.data!),
                            )
                          : null,
                    );
                  },
                ),

                /////==================================///// EmoneyNames

                SizedBox(height: 500),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //=======================================================// BankNames // s

  ///
  Future<void> _makeBankNameList() async {
    final bankNamesCollection = widget.isar.bankNames;

    final getBankNames = await bankNamesCollection.where().findAll();

    if (mounted) {
      setState(() {
        bankNameList = getBankNames;
      });
    }
  }

  ///
  Future<List<Widget>> _displayBankNames() async {
    final list = <Widget>[];

    for (var i = 0; i < bankNameList!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bankNameList![i].bankName),
              Row(
                children: [
                  const Text('xxx'),
                  SizedBox(width: 20),
                  Icon(Icons.input, color: Colors.greenAccent.withOpacity(0.6)),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return list;
  }

//=======================================================// BankNames // e

//=======================================================// EmoneyNames // s

  ///
  Future<void> _makeEmoneyNameList() async {
    final emoneyNamesCollection = widget.isar.emoneyNames;

    final getEmoneyNames = await emoneyNamesCollection.where().findAll();

    if (mounted) {
      setState(() {
        emoneyNameList = getEmoneyNames;
      });
    }
  }

  ///
  Future<List<Widget>> _displayEmoneyNames() async {
    final list = <Widget>[];

    for (var i = 0; i < emoneyNameList!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(emoneyNameList![i].emoneyName),
              Row(
                children: [
                  const Text('xxx'),
                  SizedBox(width: 20),
                  Icon(Icons.input, color: Colors.greenAccent.withOpacity(0.6)),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return list;
  }

//=======================================================// EmoneyNames // e
}
