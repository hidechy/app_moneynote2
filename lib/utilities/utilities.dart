import 'package:flutter/material.dart';

import '../collections/money.dart';

class Utility {
  Color getYoubiColor({
    required String date,
    required String youbiStr,
    required Map<String, String> holidayMap,
  }) {
    var color = Colors.black.withOpacity(0.2);

    switch (youbiStr) {
      case 'Sunday':
        color = Colors.redAccent.withOpacity(0.2);
        break;

      case 'Saturday':
        color = Colors.blueAccent.withOpacity(0.2);
        break;

      default:
        color = Colors.black.withOpacity(0.2);
        break;
    }

    if (holidayMap[date] != null) {
      color = Colors.greenAccent.withOpacity(0.2);
    }

    return color;
  }

  ///
  int makeCurrencySum({Money? money}) {
    var sum = 0;

    final yen_10000 = (money != null) ? money.yen_10000 : 0;
    final yen_5000 = (money != null) ? money.yen_5000 : 0;
    final yen_2000 = (money != null) ? money.yen_2000 : 0;
    final yen_1000 = (money != null) ? money.yen_1000 : 0;
    final yen_500 = (money != null) ? money.yen_500 : 0;
    final yen_100 = (money != null) ? money.yen_100 : 0;
    final yen_50 = (money != null) ? money.yen_50 : 0;
    final yen_10 = (money != null) ? money.yen_10 : 0;
    final yen_5 = (money != null) ? money.yen_5 : 0;
    final yen_1 = (money != null) ? money.yen_1 : 0;

    // ignore: join_return_with_assignment
    sum = (yen_10000 * 10000) +
        (yen_5000 * 5000) +
        (yen_2000 * 2000) +
        (yen_1000 * 1000) +
        (yen_500 * 500) +
        (yen_100 * 100) +
        (yen_50 * 50) +
        (yen_10 * 10) +
        (yen_5 * 5) +
        (yen_1 * 1);

    return sum;
  }
//
// ///
// int makeTotalMoney({required int currencySum, required WidgetRef ref, required DateTime date}) {
//   var totalMoney = 0;
//
//   final list = <int>[currencySum];
//
//   final bankPriceState = ref.watch(bankPriceProvider);
//
//   final bankPriceDatePadMap = (bankPriceState.bankPriceDatePadMap.value != null)
//       ? bankPriceState.bankPriceDatePadMap.value
//       : <String, Map<String, int>>{};
//
//   bankPriceDatePadMap?.forEach((key, value) {
//     value.forEach((key2, value2) {
//       if (date.yyyymmdd == key2) {
//         list.add(value2);
//       }
//     });
//   });
//
//   list.forEach((element) => totalMoney += element);
//
//   return totalMoney;
// }
//
// ///
// Future<String> getMoneyMinDate({required WidgetRef ref}) async {
//   var moneyMinDate = '';
//
//   final moneyList = ref.watch(moneyProvider.select((value) => value.moneyList));
//
//   final dateList = <String>[];
//   moneyList.value?.forEach((element) {
//     dateList.add(element.date);
//   });
//
//   dateList.sort((a, b) => a.compareTo(b));
//
//   if (dateList.isNotEmpty) {
//     moneyMinDate = dateList[0];
//   }
//
//   return moneyMinDate;
// }
//
//
//
//
}
