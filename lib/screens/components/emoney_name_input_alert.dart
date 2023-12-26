import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/emoney_name.dart';
import '../../enums/deposit_type.dart';
import '../../extensions/extensions.dart';

import 'parts/error_dialog.dart';

// ignore: must_be_immutable
class EmoneyNameInputAlert extends ConsumerStatefulWidget {
  EmoneyNameInputAlert({super.key, required this.depositType, required this.isar, this.emoneyName});

  final DepositType depositType;
  final Isar isar;
  EmoneyName? emoneyName;

  @override
  ConsumerState<EmoneyNameInputAlert> createState() => _EmoneyNameInputAlertState();
}

class _EmoneyNameInputAlertState extends ConsumerState<EmoneyNameInputAlert> {
  final TextEditingController _emoneyNameEditingController = TextEditingController();

  late BuildContext _context;

  ///
  @override
  void initState() {
    super.initState();

    if (widget.emoneyName != null) {
      _emoneyNameEditingController.text = widget.emoneyName!.emoneyName;
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

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
              const Text('電子マネー追加'),
              Divider(
                color: Colors.white.withOpacity(0.4),
                thickness: 5,
              ),
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
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _emoneyNameEditingController,
                      decoration: const InputDecoration(labelText: '電子マネー名称'),
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
                  (widget.emoneyName != null)
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: _updateEmoneyName,
                              child: Text('電子マネーを更新する',
                                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary)),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: _deleteEmoneyName,
                              child: Text('電子マネーを削除する',
                                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary)),
                            ),
                          ],
                        )
                      : TextButton(
                          onPressed: _inputEmoneyName,
                          child: const Text('電子マネーを追加する', style: TextStyle(fontSize: 12)),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _inputEmoneyName() async {
    if (_emoneyNameEditingController.text == '') {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: _context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    final emoneyName = EmoneyName()
      ..emoneyName = _emoneyNameEditingController.text
      ..depositType = widget.depositType.japanName;

    await widget.isar.writeTxn(() async => widget.isar.emoneyNames.put(emoneyName));

    _emoneyNameEditingController.clear();

    if (mounted) {
      Navigator.pop(_context);
    }
  }

  ///
  Future<void> _updateEmoneyName() async {
    if (_emoneyNameEditingController.text == '') {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: _context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    final emoneyNameCollection = widget.isar.emoneyNames;

    await widget.isar.writeTxn(() async {
      final emoneyName = await emoneyNameCollection.get(widget.emoneyName!.id);

      emoneyName!
        ..emoneyName = _emoneyNameEditingController.text
        ..depositType = widget.depositType.japanName;

      await emoneyNameCollection.put(emoneyName);
    });

    _emoneyNameEditingController.clear();

    if (mounted) {
      Navigator.pop(_context);
    }
  }

  ///
  Future<void> _deleteEmoneyName() async {
    final emoneyNameCollection = widget.isar.emoneyNames;

    await widget.isar.writeTxn(() async => emoneyNameCollection.delete(widget.emoneyName!.id));

    if (mounted) {
      Navigator.pop(_context);
    }
  }
}
