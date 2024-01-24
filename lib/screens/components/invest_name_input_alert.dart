import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:money_note/enums/invest_type.dart';
import 'package:money_note/state/invest/invest_notifier.dart';

import '../../extensions/extensions.dart';

class InvestNameInputAlert extends ConsumerStatefulWidget {
  const InvestNameInputAlert({super.key, required this.isar});

  final Isar isar;

  @override
  ConsumerState<InvestNameInputAlert> createState() => _InvestNameInputAlertState();
}

class _InvestNameInputAlertState extends ConsumerState<InvestNameInputAlert> {
  final TextEditingController _investNameEditingController = TextEditingController();

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
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              const Text('投資商品名称登録'),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              _displayInputParts(),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(),
              //     (widget.emoneyName != null)
              //         ? Column(
              //       children: [
              //         GestureDetector(
              //           onTap: _updateEmoneyName,
              //           child: Text('電子マネーを更新する',
              //               style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary)),
              //         ),
              //         const SizedBox(height: 10),
              //         GestureDetector(
              //           onTap: _showDeleteDialog,
              //           child: Text('電子マネーを削除する',
              //               style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary)),
              //         ),
              //       ],
              //     )
              //         : TextButton(
              //       onPressed: _inputEmoneyName,
              //       child: const Text('電子マネーを追加する', style: TextStyle(fontSize: 12)),
              //     ),
              //   ],
              // ),
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
                  keyboardType: TextInputType.number,
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
                  onChanged: (value) {
                    ref.read(investProvider.notifier).setSelectedInvestItem(item: value!);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
