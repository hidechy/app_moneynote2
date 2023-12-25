import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:money_note/collections/bank_price.dart';
import 'package:money_note/collections/emoney_name.dart';

import '../../collections/bank_name.dart';

import '../../extensions/extensions.dart';

class DummyDataInputAlert extends StatelessWidget {
  const DummyDataInputAlert({super.key, required this.isar});

  final Isar isar;

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: context.screenSize.width),
                ElevatedButton(
                  onPressed: () {
                    _inputBankName(
                      bankName: BankName()
                        ..bankNumber = '0001'
                        ..bankName = 'みずほ銀行'
                        ..branchNumber = '046'
                        ..branchName = '虎ノ門支店'
                        ..accountType = '普通口座'
                        ..accountNumber = '2961375'
                        ..depositType = 'bank',
                    );
                  },
                  child: const Text('みずほ銀行'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankName(
                      bankName: BankName()
                        ..bankNumber = '0009'
                        ..bankName = '三井住友銀行'
                        ..branchNumber = '547'
                        ..branchName = '横浜駅前支店'
                        ..accountType = '普通口座'
                        ..accountNumber = '8981660'
                        ..depositType = 'bank',
                    );
                  },
                  child: const Text('三井住友銀行547'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankName(
                      bankName: BankName()
                        ..bankNumber = '0009'
                        ..bankName = '三井住友銀行'
                        ..branchNumber = '259'
                        ..branchName = '新宿西口支店'
                        ..accountType = '普通口座'
                        ..accountNumber = '2967733'
                        ..depositType = 'bank',
                    );
                  },
                  child: const Text('三井住友銀行259'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankName(
                      bankName: BankName()
                        ..bankNumber = '0005'
                        ..bankName = '三菱UFJ銀行'
                        ..branchNumber = '271'
                        ..branchName = '船橋支店'
                        ..accountType = '普通口座'
                        ..accountNumber = '0782619'
                        ..depositType = 'bank',
                    );
                  },
                  child: const Text('三菱UFJ銀行'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankName(
                      bankName: BankName()
                        ..bankNumber = '0036'
                        ..bankName = '楽天銀行'
                        ..branchNumber = '226'
                        ..branchName = 'ギター支店'
                        ..accountType = '普通口座'
                        ..accountNumber = '2994905'
                        ..depositType = 'bank',
                    );
                  },
                  child: const Text('楽天銀行'),
                ),
                Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
                ElevatedButton(
                  onPressed: () {
                    _inputEmoneyName(
                      emoneyName: EmoneyName()
                        ..emoneyName = 'Suica1'
                        ..depositType = 'emoney',
                    );
                  },
                  child: const Text('Suica1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputEmoneyName(
                      emoneyName: EmoneyName()
                        ..emoneyName = 'PayPay'
                        ..depositType = 'emoney',
                    );
                  },
                  child: const Text('PayPay'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputEmoneyName(
                      emoneyName: EmoneyName()
                        ..emoneyName = 'PASMO'
                        ..depositType = 'emoney',
                    );
                  },
                  child: const Text('PASMO'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputEmoneyName(
                      emoneyName: EmoneyName()
                        ..emoneyName = 'Suica2'
                        ..depositType = 'emoney',
                    );
                  },
                  child: const Text('Suica2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputEmoneyName(
                      emoneyName: EmoneyName()
                        ..emoneyName = 'メルカリ'
                        ..depositType = 'emoney',
                    );
                  },
                  child: const Text('メルカリ'),
                ),
                Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
                ElevatedButton(
                  onPressed: () {
                    _inputBankPrice(
                      bankPrice: BankPrice()
                        ..date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3).yyyymmdd
                        ..depositType = 'bank'
                        ..bankId = 1
                        ..price = 10000,
                    );
                  },
                  child: const Text('price bank-1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankPrice(
                      bankPrice: BankPrice()
                        ..date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3).yyyymmdd
                        ..depositType = 'bank'
                        ..bankId = 2
                        ..price = 20000,
                    );
                  },
                  child: const Text('price bank-2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankPrice(
                      bankPrice: BankPrice()
                        ..date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3).yyyymmdd
                        ..depositType = 'bank'
                        ..bankId = 3
                        ..price = 30000,
                    );
                  },
                  child: const Text('price bank-3'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankPrice(
                      bankPrice: BankPrice()
                        ..date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3).yyyymmdd
                        ..depositType = 'bank'
                        ..bankId = 4
                        ..price = 40000,
                    );
                  },
                  child: const Text('price bank-4'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankPrice(
                      bankPrice: BankPrice()
                        ..date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3).yyyymmdd
                        ..depositType = 'bank'
                        ..bankId = 5
                        ..price = 50000,
                    );
                  },
                  child: const Text('price bank-5'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankPrice(
                      bankPrice: BankPrice()
                        ..date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3).yyyymmdd
                        ..depositType = 'emoney'
                        ..bankId = 1
                        ..price = 10000,
                    );
                  },
                  child: const Text('emoney-1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankPrice(
                      bankPrice: BankPrice()
                        ..date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3).yyyymmdd
                        ..depositType = 'emoney'
                        ..bankId = 2
                        ..price = 20000,
                    );
                  },
                  child: const Text('emoney-2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankPrice(
                      bankPrice: BankPrice()
                        ..date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3).yyyymmdd
                        ..depositType = 'emoney'
                        ..bankId = 3
                        ..price = 30000,
                    );
                  },
                  child: const Text('emoney-3'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankPrice(
                      bankPrice: BankPrice()
                        ..date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3).yyyymmdd
                        ..depositType = 'emoney'
                        ..bankId = 4
                        ..price = 40000,
                    );
                  },
                  child: const Text('emoney-4'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _inputBankPrice(
                      bankPrice: BankPrice()
                        ..date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3).yyyymmdd
                        ..depositType = 'emoney'
                        ..bankId = 5
                        ..price = 50000,
                    );
                  },
                  child: const Text('emoney-5'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _inputBankName({required BankName bankName}) async {
    await isar.writeTxn(() async => isar.bankNames.put(bankName));
  }

  ///
  Future<void> _inputEmoneyName({required EmoneyName emoneyName}) async {
    await isar.writeTxn(() async => isar.emoneyNames.put(emoneyName));
  }

  ///
  Future<void> _inputBankPrice({required BankPrice bankPrice}) async {
    await isar.writeTxn(() async => isar.bankPrices.put(bankPrice));
  }
}
