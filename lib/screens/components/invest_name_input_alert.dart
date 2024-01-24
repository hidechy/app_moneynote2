import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/invest_name.dart';
import '../../enums/invest_type.dart';
import '../../extensions/extensions.dart';
import '../../state/invest/invest_notifier.dart';
import 'parts/error_dialog.dart';

class InvestNameInputAlert extends ConsumerStatefulWidget {
  const InvestNameInputAlert({super.key, required this.isar});

  final Isar isar;

  @override
  ConsumerState<InvestNameInputAlert> createState() => _InvestNameInputAlertState();
}

class _InvestNameInputAlertState extends ConsumerState<InvestNameInputAlert> {
  final TextEditingController _investNameEditingController = TextEditingController();

  late List<InvestName>? _investNameList;

  ///
  void _init() {
    _makeInvestNameList();
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
              const Text('投資商品名称登録'),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              _displayInputParts(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  TextButton(
                    onPressed: _inputInvestName,
                    child: const Text('消費アイテムを追加する', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              Expanded(child: _displayInvestNamesList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
    final investNameList = <String>[''];
    InvestType.values.forEach((element) => investNameList.add(element.japanName));

    final selectedInvestItem = ref.watch(investProvider.select((value) => value.selectedInvestItem));

    return DecoratedBox(
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
              children: [
                TextField(
                  controller: _investNameEditingController,
                  decoration: const InputDecoration(labelText: '投資商品名称'),
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                ),
                DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.pinkAccent.withOpacity(0.1),
                  iconEnabledColor: Colors.white,
                  items: investNameList.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e, style: const TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                  value: selectedInvestItem,
                  onChanged: (value) => ref.read(investProvider.notifier).setSelectedInvestItem(item: value!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _inputInvestName() async {
    if (_investNameEditingController.text == '') {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    final selectedInvestItem = ref.watch(investProvider.select((value) => value.selectedInvestItem));

    final investName = InvestName()
      ..investName = _investNameEditingController.text
      ..investType = selectedInvestItem;

    await widget.isar.writeTxn(() async => widget.isar.investNames.put(investName));

    _investNameEditingController.clear();

    await ref.read(investProvider.notifier).setSelectedInvestItem(item: '');
  }

  ///
  Future<void> _makeInvestNameList() async {
    final investNamesCollection = widget.isar.investNames;

    final getInvestNames = await investNamesCollection.where().findAll();

    setState(() => _investNameList = getInvestNames);
  }

  ///
  Widget _displayInvestNamesList() {
    final list = <Widget>[];

    final investNameEnMap = <String, String>{};
    InvestType.values.forEach((element) => investNameEnMap[element.japanName] = element.name);

    if (_investNameList!.isNotEmpty) {
      _investNameList!.forEach((element) {
        list.add(GestureDetector(
          onLongPress: () => _showDeleteDialog(id: element.id),
          child: Container(
            width: context.screenSize.width,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.4))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(investNameEnMap[element.investType] ?? '', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                Text(element.investName),
              ],
            ),
          ),
        ));
      });
    }

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  void _showDeleteDialog({required int id}) {
    final Widget cancelButton = TextButton(onPressed: () => Navigator.pop(context), child: const Text('いいえ'));

    final Widget continueButton = TextButton(
        onPressed: () {
          _deleteInvestName(id: id);

          Navigator.pop(context);
        },
        child: const Text('はい'));

    final alert = AlertDialog(
      backgroundColor: Colors.blueGrey.withOpacity(0.3),
      content: const Text('このデータを消去しますか？'),
      actions: [cancelButton, continueButton],
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  ///
  Future<void> _deleteInvestName({required int id}) async {
    final investNamesCollection = widget.isar.investNames;
    await widget.isar.writeTxn(() async => investNamesCollection.delete(id));
  }
}
