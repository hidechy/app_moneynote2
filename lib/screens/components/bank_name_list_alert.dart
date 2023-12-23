import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/bank_name.dart';
import '../../enums/deposit_type.dart';
import '../../extensions/extensions.dart';
import 'bank_name_input_alert.dart';
import 'parts/money_dialog.dart';

class BankNameListAlert extends ConsumerStatefulWidget {
  const BankNameListAlert({super.key, required this.isar});

  final Isar isar;

  @override
  ConsumerState<BankNameListAlert> createState() => _BankNameListAlertState();
}

class _BankNameListAlertState extends ConsumerState<BankNameListAlert> {
  List<BankName>? bankNames = [];

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
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  TextButton(
                    onPressed: () => MoneyDialog(
                      context: context,
                      widget: BankNameInputAlert(isar: widget.isar, depositType: DepositType.bank),
                    ),
                    child: const Text('金融機関を追加する'),
                  ),
                ],
              ),
              FutureBuilder<List<Widget>>(
                future: _displayBankNames(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Column(children: snapshot.data!),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _readBankNames() async {
    final bankNamesCollection = widget.isar.bankNames;

    final getBankNames = await bankNamesCollection.where().findAll();

    setState(() {
      bankNames = getBankNames;
    });
  }

  ///
  Future<List<Widget>> _displayBankNames() async {
    await _readBankNames();

    final list = <Widget>[];

    for (var i = 0; i < bankNames!.length; i++) {
      list.add(
        Text(bankNames![i].bankName),
      );
    }

    return list;
  }
}

/*

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:money_note/collections/bank_name.dart';

import '../../enums/deposit_type.dart';
import '../../extensions/extensions.dart';
import '../../state/main/main_notifier.dart';
import 'parts/money_dialog.dart';
import 'bank_name_input_alert.dart';

// ignore: must_be_immutable
class BankNameListAlert extends ConsumerWidget {
  BankNameListAlert({super.key});

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

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
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  TextButton(
                    onPressed: () => MoneyDialog(
                      context: context,
                      widget: const BankNameInputAlert(depositType: DepositType.bank),
                    ),
                    child: const Text('金融機関を追加する'),
                  ),
                ],
              ),
              FutureBuilder<List<Widget>>(
                future: _displayBankNames(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Column(children: snapshot.data!),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<List<Widget>> _displayBankNames() async {
    List<Widget> list = [];

    var isar = _ref.watch(mainProvider.select((value) => value.isar));

    if (isar != null) {
      final bankNamesCollection = isar.bankNames;

      final getBankNames = await bankNamesCollection.where().findAll();

      for (var i = 0; i < getBankNames.length; i++) {
        list.add(Text(getBankNames[i].bankName));
      }
    }

    return list;
  }
}
*/
