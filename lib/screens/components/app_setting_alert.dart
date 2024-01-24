import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/config.dart';
import '../../extensions/extensions.dart';
import '../../state/app_params/app_params_notifier.dart';

class AppSettingAlert extends ConsumerStatefulWidget {
  const AppSettingAlert({super.key, required this.isar});

  final Isar isar;

  @override
  ConsumerState<AppSettingAlert> createState() => _AppSettingAlertState();
}

class _AppSettingAlertState extends ConsumerState<AppSettingAlert> {
  final Map<String, int> _configIdMap = {};
  final Map<String, String> _configMap = {};

  ///
  void _init() {
    _makeConfigMap();
  }

  ///
  @override
  Widget build(BuildContext context) {
    Future(_init);

    final appParamState = ref.watch(appParamProvider);

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
              const Text('設定'),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    SwitchListTile(
                      tileColor: Colors.blueGrey.withOpacity(0.3),
                      title: const Text('投資情報を表示する', style: TextStyle(fontSize: 12)),
                      value: (_configMap['investInfoDisplayFlag'] != null)
                          // ignore: avoid_bool_literals_in_conditional_expressions
                          ? (_configMap['investInfoDisplayFlag'] == 'on')
                              ? true
                              : false
                          : appParamState.investInfoDisplayFlag,
                      onChanged: (bool? value) {
                        ref
                            .read(appParamProvider.notifier)
                            .setInvestInfoDisplayFlag(flag: !appParamState.investInfoDisplayFlag);

                        configInsertUpdate(key: 'investInfoDisplayFlag', value: !appParamState.investInfoDisplayFlag);
                      },
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _makeConfigMap() async {
    final configsCollection = widget.isar.configs;

    final getConfigs = await configsCollection.where().findAll();

    setState(() {
      getConfigs.forEach((element) {
        _configMap[element.configKey] = element.configValue;
        _configIdMap[element.configKey] = element.id;
      });
    });
  }

  ///
  Future<void> configInsertUpdate({required String key, required bool value}) async {
    final inputValue = value ? 'on' : 'off';

    if (_configMap[key] != null) {
      final configsCollection = widget.isar.configs;

      await widget.isar.writeTxn(() async {
        final config = await configsCollection.get(_configIdMap[key]!);

        config!
          ..configKey = key
          ..configValue = inputValue;

        await configsCollection.put(config);
      });
    } else {
      final config = Config()
        ..configKey = key
        ..configValue = inputValue;
      await widget.isar.writeTxn(() async => widget.isar.configs.put(config));
    }
  }
}
