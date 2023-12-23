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
        Container(
          // ignore: use_build_context_synchronously
          width: context.screenSize.width,
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.4))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${bankNames![i].depositType}-${bankNames![i].id}: ${bankNames![i].bankName} (${bankNames![i].bankNumber}) ',
                    ),
                    Text('${bankNames![i].branchName} (${bankNames![i].branchNumber})'),
                    Text('${bankNames![i].accountType} ${bankNames![i].accountNumber}'),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      MoneyDialog(
                        context: context,
                        widget: BankNameInputAlert(
                          depositType: DepositType.bank,
                          isar: widget.isar,
                          bankName: bankNames![i],
                        ),
                      );
                    },
                    child: Icon(Icons.edit, size: 16, color: Colors.greenAccent.withOpacity(0.6)),
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
}
