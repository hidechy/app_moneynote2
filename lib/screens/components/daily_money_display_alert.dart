import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:money_note/screens/components/spend_time_place_input_alert.dart';
import 'package:money_note/utilities/utilities.dart';

import '../../collections/bank_name.dart';
import '../../collections/bank_price.dart';
import '../../collections/emoney_name.dart';
import '../../collections/money.dart';
import '../../enums/deposit_type.dart';
import '../../extensions/extensions.dart';
import '../../state/app_params/app_params_notifier.dart';
import '../../utilities/functions.dart';
import 'bank_price_input_alert.dart';
import 'money_input_alert.dart';
import 'parts/bank_emoney_blank_message.dart';
import 'parts/money_dialog.dart';

class DailyMoneyDisplayAlert extends ConsumerStatefulWidget {
  const DailyMoneyDisplayAlert({super.key, required this.date, required this.isar});

  final DateTime date;
  final Isar isar;

  @override
  ConsumerState<DailyMoneyDisplayAlert> createState() => _DailyMoneyDisplayAlertState();
}

class _DailyMoneyDisplayAlertState extends ConsumerState<DailyMoneyDisplayAlert> {
  final Utility _utility = Utility();

  List<BankName>? bankNameList = [];
  List<EmoneyName>? emoneyNameList = [];
  List<BankPrice>? bankPriceList = [];
  List<Money>? moneyList = [];
  List<Money>? beforeMoneyList = [];

  Map<String, Map<String, int>> bankPricePadMap = {};
  Map<String, int> bankPriceTotalPadMap = {};

  int onedayDateTotal = 0;
  int beforeDateTotal = 0;

  ///
  void init() {
    _makeBankPriceList();
    _makeMoneyList();
    _makeBeforeMoneyList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    _makeBankNameList();
    _makeEmoneyNameList();

    Future(init);

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
                const SizedBox(height: 20),
                getTopInfoPlate(),

                _dispMenuButtons(),

                const SizedBox(height: 20),
                _displaySingleMoney(),
                const SizedBox(height: 20),

                /////==================================///// BankNames

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

                if (bankNameList!.isEmpty) ...[
                  const SizedBox(height: 10),
                  BankEmoneyBlankMessage(deposit: '金融機関', isar: widget.isar),
                  const SizedBox(height: 30),
                ],

                if (bankNameList!.isNotEmpty)
                  FutureBuilder<List<Widget>>(
                    future: _displayBankNames(),
                    builder: (context, snapshot) {
                      return (snapshot.hasData)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [Column(children: snapshot.data!), const SizedBox(height: 20)],
                            )
                          : Container();
                    },
                  ),

                /////==================================///// BankNames

                /////==================================///// EmoneyNames

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

                if (emoneyNameList!.isEmpty) ...[
                  const SizedBox(height: 10),
                  BankEmoneyBlankMessage(deposit: '電子マネー', index: 1, isar: widget.isar),
                  const SizedBox(height: 30),
                ],

                if (emoneyNameList!.isNotEmpty)
                  FutureBuilder<List<Widget>>(
                    future: _displayEmoneyNames(),
                    builder: (context, snapshot) {
                      return (snapshot.hasData)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [Column(children: snapshot.data!), const SizedBox(height: 20)],
                            )
                          : Container();
                    },
                  ),

                /////==================================///// EmoneyNames

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget getTopInfoPlate() {
    final oneday = widget.date.yyyymmdd;

    final beforeDate =
        DateTime(oneday.split('-')[0].toInt(), oneday.split('-')[1].toInt(), oneday.split('-')[2].toInt() - 1);

    final onedayBankTotal = (bankPriceTotalPadMap[oneday] != null) ? bankPriceTotalPadMap[oneday] : 0;
    final beforeBankTotal =
        (bankPriceTotalPadMap[beforeDate.yyyymmdd] != null) ? bankPriceTotalPadMap[beforeDate.yyyymmdd] : 0;

    return Container(
      width: context.screenSize.width,
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Start'),
                Text((beforeDateTotal + beforeBankTotal!).toString().toCurrency()),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('End'),
                Text((onedayDateTotal + onedayBankTotal!).toString().toCurrency()),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Spend'),
                Text(((beforeDateTotal + beforeBankTotal) - (onedayDateTotal + onedayBankTotal))
                    .toString()
                    .toCurrency()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget _displaySingleMoney() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _displayMoneyParts(key: '10000', value: (moneyList!.isNotEmpty) ? moneyList![0].yen_10000 : 0),
        _displayMoneyParts(key: '5000', value: (moneyList!.isNotEmpty) ? moneyList![0].yen_5000 : 0),
        _displayMoneyParts(key: '2000', value: (moneyList!.isNotEmpty) ? moneyList![0].yen_2000 : 0),
        _displayMoneyParts(key: '1000', value: (moneyList!.isNotEmpty) ? moneyList![0].yen_1000 : 0),
        _displayMoneyParts(key: '500', value: (moneyList!.isNotEmpty) ? moneyList![0].yen_500 : 0),
        _displayMoneyParts(key: '100', value: (moneyList!.isNotEmpty) ? moneyList![0].yen_100 : 0),
        _displayMoneyParts(key: '50', value: (moneyList!.isNotEmpty) ? moneyList![0].yen_50 : 0),
        _displayMoneyParts(key: '10', value: (moneyList!.isNotEmpty) ? moneyList![0].yen_10 : 0),
        _displayMoneyParts(key: '5', value: (moneyList!.isNotEmpty) ? moneyList![0].yen_5 : 0),
        _displayMoneyParts(key: '1', value: (moneyList!.isNotEmpty) ? moneyList![0].yen_1 : 0),
        const SizedBox(height: 20),
      ],
    );
  }

  ///
  Widget _displayMoneyParts({required String key, required int value}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(key), Text(value.toString().toCurrency())],
      ),
    );
  }

  ///
  Future<void> _makeMoneyList() async {
    final moneyCollection = widget.isar.moneys;

    final getMoneys = await moneyCollection.filter().dateEqualTo(widget.date.yyyymmdd).findAll();

    setState(() {
      moneyList = getMoneys;

      if (moneyList!.isNotEmpty) {
        onedayDateTotal = _utility.makeCurrencySum(money: moneyList![0]);
      }
    });
  }

  ///
  Future<void> _makeBeforeMoneyList() async {
    final moneyCollection = widget.isar.moneys;

    final oneday = widget.date.yyyymmdd;

    final beforeDate =
        DateTime(oneday.split('-')[0].toInt(), oneday.split('-')[1].toInt(), oneday.split('-')[2].toInt() - 1);

    final getBeforeDateMoneys = await moneyCollection.filter().dateEqualTo(beforeDate.yyyymmdd).findAll();

    setState(() {
      beforeMoneyList = getBeforeDateMoneys;

      if (beforeMoneyList!.isNotEmpty) {
        beforeDateTotal = _utility.makeCurrencySum(money: beforeMoneyList![0]);
      }
    });
  }

  ///
  Widget _dispMenuButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => ref.read(appParamProvider.notifier).setMenuNumber(menuNumber: 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Icon(Icons.close, color: Colors.yellowAccent.withOpacity(0.6), size: 16),
              ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => ref.read(appParamProvider.notifier).setMenuNumber(menuNumber: 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Icon(Icons.input, color: Colors.greenAccent.withOpacity(0.6), size: 16),
              ),
            ),
            if (onedayDateTotal > 0) ...[
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () => ref.read(appParamProvider.notifier).setMenuNumber(menuNumber: 2),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Icon(Icons.info_outline_rounded, color: Colors.greenAccent.withOpacity(0.6), size: 16),
                ),
              ),
            ],
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => ref.read(appParamProvider.notifier).setMenuNumber(menuNumber: 3),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Icon(Icons.monetization_on, color: Colors.greenAccent.withOpacity(0.6), size: 16),
              ),
            ),
          ],
        ),
        _getMenuOpenStr(),
      ],
    );
  }

  ///
  Widget _getMenuOpenStr() {
    final menuNumber = ref.watch(appParamProvider.select((value) => value.menuNumber));

    switch (menuNumber) {
      case 1:
        return Row(
          children: [
            const Text('金種枚数登録'),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                MoneyDialog(
                  context: context,
                  widget: MoneyInputAlert(
                    date: widget.date,
                    isar: widget.isar,
                    onedayMoneyList: moneyList,
                    beforedayMoneyList: beforeMoneyList,
                  ),
                );
              },
              child: Text('OPEN', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
          ],
        );

      case 2:
        final oneday = widget.date.yyyymmdd;

        final beforeDate =
            DateTime(oneday.split('-')[0].toInt(), oneday.split('-')[1].toInt(), oneday.split('-')[2].toInt() - 1);

        final onedayBankTotal = (bankPriceTotalPadMap[oneday] != null) ? bankPriceTotalPadMap[oneday] : 0;
        final beforeBankTotal =
            (bankPriceTotalPadMap[beforeDate.yyyymmdd] != null) ? bankPriceTotalPadMap[beforeDate.yyyymmdd] : 0;

        return Row(
          children: [
            const Text('使用詳細登録'),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () async {
                await MoneyDialog(
                  context: context,
                  widget: SpendTimePlaceInputAlert(
                    date: widget.date,
                    spend: (beforeDateTotal + beforeBankTotal!) - (onedayDateTotal + onedayBankTotal!),
                    isar: widget.isar,
                  ),
                );
              },
              child: Text('OPEN', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
          ],
        );

      case 3:
        return Row(
          children: [
            const Text('収入履歴登録'),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                // _ref.read(appParamProvider.notifier).setSelectedIncomeYear(year: '');
                //
                // MoneyDialog(context: _context, widget: IncomeListAlert(date: date));
              },
              child: Text('OPEN', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
          ],
        );
    }

    return Container();
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
                  Text(
                    _getListPrice(depositType: bankNameList![i].depositType, id: bankNameList![i].id)
                        .toString()
                        .toCurrency(),
                  ),
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
                  Text(
                    _getListPrice(depositType: emoneyNameList![i].depositType, id: emoneyNameList![i].id)
                        .toString()
                        .toCurrency(),
                  ),
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

//=======================================================// BankPrices // s

  ///
  Future<void> _makeBankPriceList() async {
    final bankPricesCollection = widget.isar.bankPrices;

    final getBankPrices = await bankPricesCollection.where().findAll();

    if (mounted) {
      setState(() {
        bankPriceList = getBankPrices;

        if (bankPriceList != null) {
          final bankPriceMap = makeBankPriceMap(bankPriceList: bankPriceList!);
          bankPricePadMap = bankPriceMap['bankPriceDatePadMap'];
          bankPriceTotalPadMap = bankPriceMap['bankPriceTotalPadMap'];
        }
      });
    }
  }

  ///
  int _getListPrice({required String depositType, required int id}) {
    var listPrice = 0;
    if (bankPricePadMap['$depositType-$id'] != null) {
      final bankPriceMap = bankPricePadMap['$depositType-$id'];
      if (bankPriceMap![widget.date.yyyymmdd] != null) {
        listPrice = bankPriceMap[widget.date.yyyymmdd]!;
      }
    }

    return listPrice;
  }

//=======================================================// BankPrices // s
}
