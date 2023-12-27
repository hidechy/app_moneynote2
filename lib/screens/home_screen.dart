import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../collections/bank_price.dart';
import '../collections/money.dart';
import '../extensions/extensions.dart';
import '../state/app_params/app_params_notifier.dart';
import '../state/calendars/calendars_notifier.dart';
import '../state/holidays/holidays_notifier.dart';
import '../utilities/functions.dart';
import '../utilities/utilities.dart';
import 'components/___dummy_data_input_alert.dart';
import 'components/daily_money_display_alert.dart';
import 'components/deposit_tab_alert.dart';
import 'components/income_input_alert.dart';
import 'components/parts/back_ground_image.dart';
import 'components/parts/custom_shape_clipper.dart';
import 'components/parts/menu_head_icon.dart';
import 'components/parts/money_dialog.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key, this.baseYm, required this.isar});

  String? baseYm;
  final Isar isar;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime _calendarMonthFirst = DateTime.now();
  final List<String> _youbiList = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  List<String> _calendarDays = [];

  Map<String, String> _holidayMap = {};

  final Utility _utility = Utility();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Money>? moneyList = [];
  Map<String, int> monthDateSumMap = {};

  List<BankPrice>? bankPriceList = [];

  Map<String, Map<String, int>> bankPricePadMap = {};
  Map<String, int> bankPriceTotalPadMap = {};

  ///
  void _init() {
    _makeMoneyList();
    _makeBankPriceList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    Future(_init);

    if (widget.baseYm != null) {
      Future(() => ref.read(calendarProvider.notifier).setCalendarYearMonth(baseYm: widget.baseYm));
    }

    final calendarState = ref.watch(calendarProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.3),
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(calendarState.baseYearMonth),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
            icon: Icon(Icons.settings, color: Colors.white.withOpacity(0.6), size: 20),
          )
        ],
      ),
      body: Stack(
        children: [
          const BackGroundImage(),
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: context.screenSize.height * 0.9,
              width: context.screenSize.width * 0.9,
              margin: const EdgeInsets.only(top: 5, left: 6),
              color: const Color(0xFFFBB6CE).withOpacity(0.6),
              child: Text('■', style: TextStyle(color: Colors.white.withOpacity(0.1))),
            ),
          ),
          Container(
            width: context.screenSize.width,
            height: context.screenSize.height,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
          ),
          SafeArea(
            child: Column(
              children: [
                _displayPrevNextButton(),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: context.screenSize.height * 0.3),
                  child: _getCalendar(),
                ),
              ],
            ),
          ),
        ],
      ),
      endDrawer: _dispDrawer(),
    );
  }

  ///
  Widget _displayPrevNextButton() {
    final calendarState = ref.watch(calendarProvider);

    return Container(
      width: context.screenSize.width,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          IconButton(
            onPressed: _goPrevMonth,
            icon: Icon(Icons.arrow_back_ios, color: Colors.white.withOpacity(0.8), size: 14),
          ),
          IconButton(
            onPressed: (DateTime.now().yyyymm == calendarState.baseYearMonth) ? null : _goNextMonth,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: (DateTime.now().yyyymm == calendarState.baseYearMonth)
                  ? Colors.grey.withOpacity(0.6)
                  : Colors.white.withOpacity(0.8),
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget _dispDrawer() {
    const isRelease = bool.fromEnvironment('dart.vm.product');

    return Drawer(
      backgroundColor: Colors.blueGrey.withOpacity(0.2),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              if (!isRelease)
                GestureDetector(
                  onTap: () async => MoneyDialog(context: context, widget: DummyDataInputAlert(isar: widget.isar)),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.4))),
                    child: const Text('dummy data'),
                  ),
                ),
              GestureDetector(
                onTap: () async => MoneyDialog(context: context, widget: DepositTabAlert(isar: widget.isar)),
                child: Row(
                  children: [
                    const MenuHeadIcon(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                        margin: const EdgeInsets.all(5),
                        child: const Text('金融機関、電子マネー管理'),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await ref.read(appParamProvider.notifier).setSelectedIncomeYear(year: '');

                  // ignore: use_build_context_synchronously
                  await MoneyDialog(
                    context: context,
                    widget: IncomeInputAlert(
                      date: (widget.baseYm != null) ? DateTime.parse('${widget.baseYm}-01 00:00:00') : DateTime.now(),
                      isar: widget.isar,
                    ),
                  );
                },
                child: Row(
                  children: [
                    const MenuHeadIcon(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                        margin: const EdgeInsets.all(5),
                        child: const Text('収入管理'),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  showLicensePage(
                    context: context,
                    applicationIcon: const FlutterLogo(),
                    applicationName: 'Money Note',
                    applicationLegalese: '\u{a9} ${DateTime.now().year} toyohide',
                    applicationVersion: '1.0',
                  );
                },
                child: Row(
                  children: [
                    const MenuHeadIcon(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                        margin: const EdgeInsets.all(5),
                        child: const Text('ライセンス表示'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _getCalendar() {
    final holidayState = ref.watch(holidayProvider);

    if (holidayState.holidayMap.value != null) {
      _holidayMap = holidayState.holidayMap.value!;
    }

    final calendarState = ref.watch(calendarProvider);

    _calendarMonthFirst = DateTime.parse('${calendarState.baseYearMonth}-01 00:00:00');

    final monthEnd = DateTime.parse('${calendarState.nextYearMonth}-00 00:00:00');

    final diff = monthEnd.difference(_calendarMonthFirst).inDays;
    final monthDaysNum = diff + 1;

    final youbi = _calendarMonthFirst.youbiStr;
    final youbiNum = _youbiList.indexWhere((element) => element == youbi);

    final weekNum = ((monthDaysNum + youbiNum) <= 35) ? 5 : 6;

    _calendarDays = List.generate(weekNum * 7, (index) => '');

    for (var i = 0; i < (weekNum * 7); i++) {
      if (i >= youbiNum) {
        final gendate = _calendarMonthFirst.add(Duration(days: i - youbiNum));

        if (_calendarMonthFirst.month == gendate.month) {
          _calendarDays[i] = gendate.day.toString();
        }
      }
    }

    final list = <Widget>[];
    for (var i = 0; i < weekNum; i++) {
      list.add(_getCalendarRow(week: i));
    }

    return DefaultTextStyle(style: const TextStyle(fontSize: 10), child: Column(children: list));
  }

  ///
  Widget _getCalendarRow({required int week}) {
    final list = <Widget>[];

    for (var i = week * 7; i < ((week + 1) * 7); i++) {
      final generateYmd = (_calendarDays[i] == '')
          ? ''
          : DateTime(_calendarMonthFirst.year, _calendarMonthFirst.month, _calendarDays[i].toInt()).yyyymmdd;

      final youbiStr = (_calendarDays[i] == '')
          ? ''
          : DateTime(_calendarMonthFirst.year, _calendarMonthFirst.month, _calendarDays[i].toInt()).youbiStr;

      var dateDiff = 0;
      var dateSum = '';
      var inputFlag = '未入力';
      if (generateYmd != '') {
        final genDate = DateTime.parse('$generateYmd 00:00:00');
        dateDiff = genDate.difference(DateTime.now()).inSeconds;

        if (monthDateSumMap[generateYmd] != null && bankPriceTotalPadMap[generateYmd] != null) {
          dateSum = (monthDateSumMap[generateYmd]! + bankPriceTotalPadMap[generateYmd]!).toString().toCurrency();
        }

        if (monthDateSumMap[generateYmd] != null) {
          inputFlag = '入力済';
        }
        if (dateDiff > 0 || bankPriceTotalPadMap[generateYmd] == null) {
          inputFlag = '';
        }
      }

      list.add(
        Expanded(
          child: GestureDetector(
            onTap: (_calendarDays[i] == '' || dateDiff > 0)
                ? null
                : () async {
                    await MoneyDialog(
                      context: context,
                      widget: DailyMoneyDisplayAlert(date: DateTime.parse('$generateYmd 00:00:00'), isar: widget.isar),
                    );
                  },
            child: Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: (_calendarDays[i] == '')
                      ? Colors.transparent
                      : (generateYmd == DateTime.now().yyyymmdd)
                          ? Colors.orangeAccent.withOpacity(0.4)
                          : Colors.white.withOpacity(0.1),
                  width: 3,
                ),
                color: (_calendarDays[i] == '')
                    ? Colors.transparent
                    : (dateDiff > 0)
                        ? Colors.white.withOpacity(0.1)
                        : _utility.getYoubiColor(date: generateYmd, youbiStr: youbiStr, holidayMap: _holidayMap),
              ),
              child: (_calendarDays[i] == '')
                  ? const Text('')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(minHeight: context.screenSize.height / 30),
                          child: Text(_calendarDays[i].padLeft(2, '0')),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Container(), Text(dateSum)],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Container(), Text(inputFlag)],
                        ),
                      ],
                    ),
            ),
          ),
        ),
      );
    }

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  ///
  Future<void> _makeMoneyList() async {
    final moneyCollection = widget.isar.moneys;

    final getMoneys = await moneyCollection.where().findAll();

    setState(() {
      moneyList = getMoneys;

      if (moneyList!.isNotEmpty) {
        moneyList!.forEach((element) => monthDateSumMap[element.date] = _utility.makeCurrencySum(money: element));
      }
    });
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
      }
    });
  }

  ///
  void _goPrevMonth() {
    final calendarState = ref.watch(calendarProvider);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(isar: widget.isar, baseYm: calendarState.prevYearMonth)),
    );
  }

  ///
  void _goNextMonth() {
    final calendarState = ref.watch(calendarProvider);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(isar: widget.isar, baseYm: calendarState.nextYearMonth)),
    );
  }
}
