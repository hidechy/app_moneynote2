import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/spend_time_place.dart';
import '../../extensions/extensions.dart';

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

  ///
  void _init() {
    _makeYearlySpendTimePlaceList();
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
              // Expanded(child: _dispDateMoneyList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _makeYearlySpendTimePlaceList() async {
    final spendTimePlacesCollection = widget.isar.spendTimePlaces;

    final getSpendTimePlaces =
        await spendTimePlacesCollection.filter().dateStartsWith(widget.date.yyyy).sortByDate().findAll();

    if (mounted) {
      setState(() => _yearlySpendTimePlaceList = getSpendTimePlaces);
    }
  }

/*




  ///
  Future<void> _makeMonthlySpendTimePlaceList() async {
    final spendTimePlacesCollection = widget.isar.spendTimePlaces;

    final yearmonth = (widget.baseYm != null) ? widget.baseYm : DateTime.now().yyyymm;

    final getSpendTimePlaces =
    await spendTimePlacesCollection.filter().dateStartsWith(yearmonth!).sortByDate().findAll();

    if (mounted) {
      setState(() => monthlySpendTimePlaceList = getSpendTimePlaces);
    }
  }
  */
}
