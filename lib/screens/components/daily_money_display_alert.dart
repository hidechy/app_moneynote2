import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:money_note/enums/deposit_type.dart';
import 'package:money_note/screens/components/bank_price_input_alert.dart';
import 'package:money_note/screens/components/parts/money_dialog.dart';

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
                Text(widget.date.yyyymmdd),
                Divider(color: Colors.white.withOpacity(0.4), thickness: 5),

                /////==================================///// BankNames

                FutureBuilder<List<Widget>>(
                  future: _displayBankNames(),
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: context.screenSize.height * 0.3,
                      child: (snapshot.hasData)
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: context.screenSize.width,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.indigo.withOpacity(0.8), Colors.transparent],
                                        stops: const [0.7, 1],
                                      ),
                                    ),
                                    child: const Text('金融機関名', overflow: TextOverflow.ellipsis),
                                  ),
                                  Column(children: snapshot.data!),
                                ],
                              ),
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
                      height: context.screenSize.height * 0.3,
                      child: (snapshot.hasData)
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: context.screenSize.width,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.indigo.withOpacity(0.8), Colors.transparent],
                                        stops: const [0.7, 1],
                                      ),
                                    ),
                                    child: const Text('電子マネー名', overflow: TextOverflow.ellipsis),
                                  ),
                                  Column(children: snapshot.data!),
                                ],
                              ),
                            )
                          : null,
                    );
                  },
                ),

                /////==================================///// EmoneyNames

                const SizedBox(height: 500),
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
      setState(() => bankNameList = getBankNames);
    }
  }

  ///
  Future<List<Widget>> _displayBankNames() async {
    await _makeBankNameList();

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
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      MoneyDialog(
                        context: context,
                        widget: BankPriceInputAlert(
                          date: widget.date,
                          isar: widget.isar,
                          depositType: DepositType.bank,
                          bankName: bankNameList![i],
                        ),
                      );
                    },
                    child: Icon(Icons.input, color: Colors.greenAccent.withOpacity(0.6)),
                  ),
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
      setState(() => emoneyNameList = getEmoneyNames);
    }
  }

  ///
  Future<List<Widget>> _displayEmoneyNames() async {
    await _makeEmoneyNameList();

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
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      MoneyDialog(
                        context: context,
                        widget: BankPriceInputAlert(
                          date: widget.date,
                          isar: widget.isar,
                          depositType: DepositType.emoney,
                          emoneyName: emoneyNameList![i],
                        ),
                      );
                    },
                    child: Icon(Icons.input, color: Colors.greenAccent.withOpacity(0.6)),
                  ),
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
