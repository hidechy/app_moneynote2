import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../collections/bank_price.dart';
import '../../collections/money.dart';
import '../../extensions/extensions.dart';
import '../../utilities/functions.dart';

class MoneyListAlert extends StatefulWidget {
  const MoneyListAlert({super.key, required this.date, required this.isar});

  final DateTime date;
  final Isar isar;

  @override
  State<MoneyListAlert> createState() => _MoneyListAlertState();
}

class _MoneyListAlertState extends State<MoneyListAlert> {
  List<Money>? moneyList = [];

  Map<String, Money> dateMoneyMap = {};

  List<BankPrice>? bankPriceList = [];

  Map<String, Map<String, int>> bankPricePadMap = {};
  Map<String, int> bankPriceTotalPadMap = {};

  Map<String, Map<String, int>> bankPricePadMapDateDepositReverse = {};

  ///
  void _init() {
    _makeMoneyList();

    _makeBankPriceList();
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
                children: [const Text('CURRENCY枚数リスト'), Text(widget.date.yyyymm)],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: _dispDateMoneyList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _makeMoneyList() async {
    dateMoneyMap = {};

    final moneyCollection = widget.isar.moneys;

    final getMoneys = await moneyCollection.where().sortByDate().findAll();

    setState(() {
      moneyList = getMoneys;

      if (moneyList!.isNotEmpty) {
        moneyList!.forEach((element) {
          dateMoneyMap[element.date] = element;
        });
      }
    });
  }

  ///
  Widget _dispDateMoneyList() {
//    print(bankPricePadMapDateDepositReverse);

    /*

flutter: {
2023-12-27: {
bank-1: 10000, bank-2: 20000, bank-3: 30000, bank-4: 40000, bank-5: 50000,
emoney-1: 10000, emoney-2: 20000, emoney-3: 30000, emoney-4: 40000, emoney-5: 50000
},

2023-12-28: {
bank-1: 10000, bank-2: 20000, bank-3: 30000, bank-4: 40000, bank-5: 50000,
emoney-1: 10000, emoney-2: 20000, emoney-3: 30000, emoney-4: 40000, emoney-5: 50000
},

2023-12-29: {
bank-1: 10000, bank-2: 20000, bank-3: 30000, bank-4: 40000, bank-5: 50000,
emoney-1: 10000, emoney-2: 20000, emoney-3: 30000, emoney-4: 40000, emoney-5: 50000
},

2023-12-30: {
bank-1: 10000, bank-2: 20000, bank-3: 30000, bank-4: 40000, bank-5: 50000,
emoney-1: 10000, emoney-2: 20000, emoney-3: 30000, emoney-4: 40000, emoney-5: 50000
},

2023-12-31: {
bank-1: 10000, bank-2: 20000, bank-3: 30000, bank-4: 40000, bank-5: 50000,
emoney-1: 10000, emoney-2: 20000, emoney-3: 30000, emoney-4: 40000, emoney-5: 50000
}

}

  */

    //---------------------// 見出し行
    final list = <Widget>[
      Row(
        children: [
          _displayBlank(),
          const SizedBox(width: 10),
          _displayMidashiList(),
        ],
      )
    ];
    //---------------------// 見出し行

    dateMoneyMap.forEach((key, value) {
      list.add(Row(
        children: [
          _displayDate(date: DateTime.parse('$key 00:00:00')),
          const SizedBox(width: 10),
          _displayCurrencyList(value: value),
        ],
      ));
    });

    return SingleChildScrollView(scrollDirection: Axis.horizontal, child: Column(children: list));
  }

  Widget _displayBlank() {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent.withOpacity(0.2)),
      ),
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(1),
      child: const Text(''),
    );
  }

  ///
  Widget _displayMidashiList() {
    const width = 70;
    final color = Colors.yellowAccent.withOpacity(0.1);

    return Row(
      children: [
        _displayCurrencyParts(
            value: 10000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 5000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 2000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 1000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 500,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 100,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 50,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 10,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 5,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
        _displayCurrencyParts(
            value: 1,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.transparent,
            alignment: Alignment.center),
      ],
    );
  }

  ///
  Widget _displayDate({required DateTime date}) {
    return Container(
      width: 140,
      decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.2))),
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(1),
      child: Text('${date.yyyymmdd}（${date.youbiStr.substring(0, 3)}）'),
    );
  }

  ///
  Widget _displayCurrencyList({required Money value}) {
    const width = 70;
    const color = Colors.transparent;

    return Row(
      children: [
        _displayCurrencyParts(
            value: value.yen_10000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_5000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_2000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_1000,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_500,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_100,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_50,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_10,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_5,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
        _displayCurrencyParts(
            value: value.yen_1,
            width: width.toDouble(),
            color: color,
            borderColor: Colors.white.withOpacity(0.2),
            alignment: Alignment.topRight),
      ],
    );
  }

  ///
  Widget _displayCurrencyParts({
    required int value,
    required double width,
    required Color color,
    required Color borderColor,
    required Alignment alignment,
  }) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: borderColor), color: color),
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(1),
      width: width,
      alignment: alignment,
      child: Text(value.toString()),
    );
  }

  ///
  Future<void> _makeBankPriceList() async {
    final bankPricesCollection = widget.isar.bankPrices;

    final getBankPrices = await bankPricesCollection.where().findAll();

    setState(() {
      bankPriceList = getBankPrices;

      if (bankPriceList != null) {
        final bankPriceMap = makeBankPriceMap(bankPriceList: bankPriceList!);
        bankPricePadMap = bankPriceMap['bankPriceDatePadMap'];
        bankPriceTotalPadMap = bankPriceMap['bankPriceTotalPadMap'];

        if (bankPricePadMap.isNotEmpty) {
          _makeBankPricePadMapDateDepositReverse(data: bankPricePadMap);
        }
      }
    });
  }

  ///
  void _makeBankPricePadMapDateDepositReverse({required Map<String, Map<String, int>> data}) {
    bankPricePadMapDateDepositReverse = {};

    final map = <String, int>{};

    data.forEach((key, value) {
      value.forEach((key2, value2) {
        map[key] = value2;
        bankPricePadMapDateDepositReverse[key2] = map;
      });
    });
  }
}
