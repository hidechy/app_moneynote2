import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/income.dart';
import '../../extensions/extensions.dart';
import '../../state/app_params/app_params_notifier.dart';
import 'parts/error_dialog.dart';

class IncomeInputAlert extends ConsumerStatefulWidget {
  const IncomeInputAlert({super.key, required this.date, required this.isar});

  final DateTime date;
  final Isar isar;

  @override
  ConsumerState<IncomeInputAlert> createState() => _IncomeListAlertState();
}

class _IncomeListAlertState extends ConsumerState<IncomeInputAlert> {
  final TextEditingController _incomePriceEditingController = TextEditingController();
  final TextEditingController _incomeSourceEditingController = TextEditingController();

  List<Income>? incomeList = [];

  List<String> yearList = [];
  List<int> sameYearMonthIdList = [];

  ///
  void _init() {
    _makeIncomeList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    Future(_init);

    final sameMonthIncomeDeleteFlag = ref.watch(appParamProvider.select((value) => value.sameMonthIncomeDeleteFlag));

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
                  const Text('収入履歴登録'),
                  Text(widget.date.yyyymmdd),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ref
                                .read(appParamProvider.notifier)
                                .setSameMonthIncomeDeleteFlag(flag: !sameMonthIncomeDeleteFlag);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: sameMonthIncomeDeleteFlag
                                  ? Colors.yellowAccent.withOpacity(0.2)
                                  : const Color(0xFFfffacd).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text('同月のデータを入れ替える'),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _incomePriceEditingController,
                      decoration: const InputDecoration(labelText: '金額'),
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _incomeSourceEditingController,
                      decoration: const InputDecoration(labelText: '支払い元'),
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  TextButton(onPressed: _insertIncome, child: const Text('入力する')),
                ],
              ),
              SizedBox(height: 40, child: _displayYearButton()),
              Expanded(child: _displayIncomeList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _makeIncomeList() async {
    yearList = [];
    sameYearMonthIdList = [];

    final map = <String, String>{};
    final map2 = <int, String>{};

    final incomesCollection = widget.isar.incomes;

    final getIncomes = await incomesCollection.where().sortByDate().findAll();

    if (mounted) {
      setState(() {
        incomeList = getIncomes;

        if (incomeList != null) {
          incomeList!.forEach((element) {
            map[element.date.split('-')[0]] = '';

            // ignore: literal_only_boolean_expressions
            if (widget.date.yyyymm == '${element.date.split('-')[0]}-${element.date.split('-')[1]}') {
              map2[element.id] = '';
            }
          });

          map.forEach((key, value) {
            yearList.add(key);
          });

          map2.forEach((key, value) {
            sameYearMonthIdList.add(key);
          });
        }
      });
    }
  }

  ///
  Widget _displayYearButton() {
    final selectedIncomeYear = ref.watch(appParamProvider.select((value) => value.selectedIncomeYear));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              await ref.read(appParamProvider.notifier).setSelectedIncomeYear(year: '');
              // await IncomeRepository().selectByYear(year: '', ref: ref);
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: (selectedIncomeYear == '') ? Colors.yellowAccent.withOpacity(0.2) : Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.close, size: 14),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: yearList.map((e) {
              return GestureDetector(
                onTap: () async {
                  await ref.read(appParamProvider.notifier).setSelectedIncomeYear(year: e);
                  // await IncomeRepository().selectByYear(year: e, ref: ref);
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: (selectedIncomeYear == e) ? Colors.yellowAccent.withOpacity(0.2) : Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(e),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  ///
  Widget _displayIncomeList() {
    final list = <Widget>[];

    var icList = <Income>[];

    if (incomeList!.isNotEmpty) {
      final selectedIncomeYear = ref.watch(appParamProvider.select((value) => value.selectedIncomeYear));

      if (selectedIncomeYear == '') {
        icList = incomeList!;
      } else {
        incomeList!.forEach((element) {
          if (element.date.split('-')[0] == selectedIncomeYear) {
            icList.add(element);
          }
        });
      }
    }

    icList.forEach((element) {
      list.add(
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(element.date),
                  Text(element.price.toString().toCurrency()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(element.sourceName),
                ],
              ),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  Future<void> _insertIncome() async {
    if (_incomePriceEditingController.text == '' || _incomeSourceEditingController.text == '') {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    final sameMonthIncomeDeleteFlag = ref.watch(appParamProvider.select((value) => value.sameMonthIncomeDeleteFlag));

    if (sameMonthIncomeDeleteFlag) {
      final incomeCollection = widget.isar.incomes;
      await widget.isar.writeTxn(() async {
        sameYearMonthIdList.forEach(incomeCollection.delete);
      });
    }

    final income = Income()
      ..date = widget.date.yyyymmdd
      ..sourceName = _incomeSourceEditingController.text
      ..price = _incomePriceEditingController.text.toInt();

    await widget.isar.writeTxn(() async => widget.isar.incomes.put(income));

    _incomeSourceEditingController.clear();
    _incomePriceEditingController.clear();

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
