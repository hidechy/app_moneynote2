import '../collections/bank_price.dart';
import '../collections/spend_time_place.dart';
import '../enums/spend_type.dart';
import '../extensions/extensions.dart';

///
Map<String, dynamic> makeBankPriceMap({required List<BankPrice> bankPriceList}) {
  final map2 = <String, List<BankPrice>>{};

  bankPriceList
    ..forEach((element) {
      map2['${element.depositType}-${element.bankId}'] = [];
    })
    ..forEach((element) {
      map2['${element.depositType}-${element.bankId}']?.add(element);
    });

  //=======================//

  final map3 = <String, Map<String, int>>{};

  if (bankPriceList.isNotEmpty) {
    //--- (1)
    final bplMap = <String, List<Map<String, int>>>{};

    bankPriceList
      ..forEach((element) {
        bplMap['${element.depositType}-${element.bankId}'] = [];
      })
      ..forEach((element) {
        bplMap['${element.depositType}-${element.bankId}']?.add({element.date: element.price});
      });
    //--- (1)

//  print(bplMap);

/*

I/flutter ( 5443): {
bank-1: [{2023-12-11: 10000}, {2023-12-12: 11000}, {2023-12-13: 12000}],
bank-2: [{2023-12-11: 20000}, {2023-12-12: 22000}],
bank-3: [{2023-12-11: 30000}, {2023-12-13: 33000}],
bank-4: [{2023-12-11: 40000}, {2023-12-13: 44000}],
bank-5: [{2023-12-11: 50000}],

emoney-1: [{2023-12-11: 10000}],
emoney-2: [{2023-12-11: 20000}],
emoney-3: [{2023-12-11: 30000}],
emoney-4: [{2023-12-11: 40000}],
emoney-5: [{2023-12-11: 50000}]}

*/

    //--- (2)
    final dt = DateTime.parse('${bankPriceList[0].date} 00:00:00');

    final now = DateTime.now();

    final diff = now.difference(dt).inDays;

    bplMap.forEach((deposit, value) {
      final map4 = <String, int>{};

      var price = 0;
      for (var i = 0; i <= diff; i++) {
        final date = dt.add(Duration(days: i)).yyyymmdd;

        value.forEach((element) {
          if (element[date] != null) {
            price = element[date] ?? 0;
          }

          map4[date] = price;
        });
      }

      map3[deposit] = map4;
    });

    //--- (2)
  }

//print(map3);
  /*
    flutter: {
    bank-1: {2023-12-17: 10000, 2023-12-18: 10000, 2023-12-19: 10000, 2023-12-20: 10000},
    bank-2: {2023-12-17: 20000, 2023-12-18: 20000, 2023-12-19: 20000, 2023-12-20: 20000},
    bank-3: {2023-12-17: 30000, 2023-12-18: 30000, 2023-12-19: 30000, 2023-12-20: 30000},
    bank-4: {2023-12-17: 40000, 2023-12-18: 40000, 2023-12-19: 40000, 2023-12-20: 40000},
    bank-5: {2023-12-17: 50000, 2023-12-18: 50000, 2023-12-19: 50000, 2023-12-20: 50000},
    emoney-1: {2023-12-17: 10000, 2023-12-18: 10000, 2023-12-19: 10000, 2023-12-20: 10000},
    emoney-2: {2023-12-17: 20000, 2023-12-18: 20000, 2023-12-19: 20000, 2023-12-20: 20000},
    emoney-3: {2023-12-17: 30000, 2023-12-18: 30000, 2023-12-19: 30000, 2023-12-20: 30000},
    emoney-4: {2023-12-17: 40000, 2023-12-18: 40000, 2023-12-19: 40000, 2023-12-20: 40000},
    emoney-5: {2023-12-17: 50000, 2023-12-18: 50000, 2023-12-19: 50000, 2023-12-20: 50000}}
    */

  //=======================//

  /////////////////////////////////

  final map4 = <String, int>{};

  final aaa = <String, List<int>>{};
  map3
    ..forEach((key, value) => value.forEach((key2, value2) => aaa[key2] = []))
    ..forEach((key, value) => value.forEach((key2, value2) => aaa[key2]?.add(value2)));

//print(aaa);
/*
flutter: {
2023-12-17: [10000, 20000, 30000, 40000, 50000, 10000, 20000, 30000, 40000, 50000],
2023-12-18: [10000, 20000, 30000, 40000, 50000, 10000, 20000, 30000, 40000, 50000],
2023-12-19: [10000, 20000, 30000, 40000, 50000, 10000, 20000, 30000, 40000, 50000],
2023-12-20: [10000, 20000, 30000, 40000, 50000, 10000, 20000, 30000, 40000, 50000]}
*/

  aaa.forEach((key, value) {
    var sum = 0;
    value.forEach((element) => sum += element);
    map4[key] = sum;
  });

// print(map4);
/*
flutter: {2023-12-17: 300000, 2023-12-18: 300000, 2023-12-19: 300000, 2023-12-20: 300000}
*/

  /////////////////////////////////

  return {'bankPriceDatePadMap': map3, 'bankPriceTotalPadMap': map4};
}

///
Map<String, int> makeMonthlySpendItemSumMap({required List<SpendTimePlace> spendTimePlaceList}) {
  final monthlySpendItemSumMap = <String, int>{};

  final list = <String>[];
  SpendType.values.forEach((element) => list.add(element.japanName!));

  final map = <String, List<int>>{};

  list.forEach((element) {
    final filtered = spendTimePlaceList.where((element2) => element2.spendType == element).toList();
    if (filtered.isNotEmpty) {
      filtered
        ..forEach((element3) => map[element3.spendType] = [])
        ..forEach((element3) => map[element3.spendType]?.add(element3.price));
    }
  });

  map.forEach((key, value) {
    var sum = 0;
    value.forEach((element) => sum += element);
    monthlySpendItemSumMap[key] = sum;
  });

  return monthlySpendItemSumMap;
}
