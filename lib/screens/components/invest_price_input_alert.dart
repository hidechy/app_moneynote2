import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/invest_name.dart';
import '../../collections/invest_price.dart';
import '../../extensions/extensions.dart';
import '../../state/invest/invest_notifier.dart';
import 'parts/error_dialog.dart';

class InvestPriceInputAlert extends ConsumerStatefulWidget {
  const InvestPriceInputAlert({super.key, required this.isar});

  final Isar isar;

  @override
  ConsumerState<InvestPriceInputAlert> createState() => _InvestPriceInputAlertState();
}

class _InvestPriceInputAlertState extends ConsumerState<InvestPriceInputAlert> {
  List<InvestName>? investNameList;

  List<InvestPrice>? investPriceList;

  final List<TextEditingController> _investPriceTecs = [];

  ///
  void _init() {
    _makeInvestNameList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    Future(_init);

    _makeTecs();

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
                  const Text('投資商品金額登録'),
                  GestureDetector(
                    onTap: _inputInvest,
                    child: Icon(Icons.input, color: Colors.greenAccent.withOpacity(0.6), size: 16),
                  ),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              _displayInputDate(),
              const SizedBox(height: 10),
              _displayClearButton(),
              const SizedBox(height: 10),
              Expanded(child: _displayInputParts()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _makeInvestNameList() async {
    final investNamesCollection = widget.isar.investNames;
    final getInvestNames = await investNamesCollection.where().findAll();
    setState(() => investNameList = getInvestNames);
  }

  ///
  Future<void> _makeInvestPriceList({required String date}) async {
    final investPricesCollection = widget.isar.investPrices;
    final getInvestPrices = await investPricesCollection.where().dateEqualTo(date).findAll();
    setState(() => investPriceList = getInvestPrices);
  }

  ///
  void _makeTecs() {
    if (investNameList != null) {
      for (var i = 0; i < investNameList!.length; i++) {
        _investPriceTecs.add(TextEditingController(text: ''));
      }
    }
  }

  ///
  Widget _displayInputDate() {
    if (investNameList == null) {
      return Container();
    }

    final investInputDate =
        ref.watch(investInputProvider(investNameList!.length).select((value) => value.investInputDate));

    final dispDate = (investInputDate != '') ? investInputDate : DateTime.now().yyyymmdd;

    Future(() => _makeInvestPriceList(date: dispDate));

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: _showDP,
                child: Icon(Icons.calendar_month, color: Colors.greenAccent.withOpacity(0.6)),
              ),
              const SizedBox(width: 10),
              Text(dispDate),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ref.read(investInputProvider(investNameList!.length).notifier).setInvestInputDate(
                        date: DateTime(
                          dispDate.split('-')[0].toInt(),
                          dispDate.split('-')[1].toInt(),
                          dispDate.split('-')[2].toInt() - 1,
                        ).yyyymmdd,
                      );
                },
                child: Icon(Icons.arrow_back_ios, color: Colors.white.withOpacity(0.8), size: 14),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  ref.read(investInputProvider(investNameList!.length).notifier).setInvestInputDate(
                        date: DateTime(
                          dispDate.split('-')[0].toInt(),
                          dispDate.split('-')[1].toInt(),
                          dispDate.split('-')[2].toInt() + 1,
                        ).yyyymmdd,
                      );
                },
                child: Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.8), size: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  Widget _displayClearButton() {
    return GestureDetector(
      onTap: () async => _clearInvestValue(),
      child: Text(
        'clear',
        style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
    final list = <Widget>[];

    if (investNameList != null) {
      for (var i = 0; i < investNameList!.length; i++) {
        list.add(DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 24, spreadRadius: 16, color: Colors.black.withOpacity(0.2)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: Container(
                width: context.screenSize.width,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(investNameList![i].investName, maxLines: 1, overflow: TextOverflow.ellipsis),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _investPriceTecs[i],
                      decoration: const InputDecoration(labelText: '金額'),
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                      onChanged: (value) {
                        if (value != '') {
                          ref.read(investInputProvider(investNameList!.length).notifier).setInputInvestValue(
                                pos: i,
                                id: investNameList![i].id,
                                price: value.toInt(),
                              );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
      }
    }

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  Future<void> _showDP() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 360)),
    );

    if (selectedDate != null) {
      await ref
          .read(investInputProvider(investNameList!.length).notifier)
          .setInvestInputDate(date: selectedDate.yyyymmdd);
    }
  }

  ///
  Future<void> _inputInvest() async {
    final investInputState = ref.watch(investInputProvider(investNameList!.length));

    final inputDate =
        (investInputState.investInputDate != '') ? investInputState.investInputDate : DateTime.now().yyyymmdd;

    final list = <InvestPrice>[];

    var errFlg = false;

    if (investNameList != null) {
      for (var i = 0; i < investNameList!.length; i++) {
        if (investInputState.investIdList[i] != 0 && investInputState.investPriceList[i] != 0) {
          list.add(
            InvestPrice()
              ..date = inputDate
              ..investId = investInputState.investIdList[i]
              ..price = investInputState.investPriceList[i],
          );
        }
      }
    }

    if (list.isEmpty) {
      errFlg = true;
    }

    if (errFlg) {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    final investPricesCollection = widget.isar.investPrices;
    await widget.isar.writeTxn(
      () async => investPriceList?.forEach((element) => investPricesCollection.delete(element.id)),
    );

    await widget.isar.writeTxn(() async {
      for (final investPrice in list) {
        await widget.isar.investPrices.put(investPrice);
      }
    });

    await _clearInvestValue();
  }

  ///
  Future<void> _clearInvestValue() async {
    await ref
        .read(investInputProvider(investNameList!.length).notifier)
        .clearInputInvestValue(investNum: investNameList!.length);

    if (investNameList != null) {
      for (var i = 0; i < investNameList!.length; i++) {
        _investPriceTecs[i] = TextEditingController(text: '');
      }
    }
  }
}
