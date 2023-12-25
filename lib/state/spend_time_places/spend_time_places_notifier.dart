import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';

import 'spend_time_places_response_state.dart';

final spendTimePlaceProvider =
    StateNotifierProvider.autoDispose<SpendTimePlaceNotifier, SpendTimePlacesResponseState>((ref) {
  final spendTime = List.generate(10, (index) => '時間');
  final spendPlace = List.generate(10, (index) => '');
  final spendItem = List.generate(10, (index) => '項目名');
  final spendPrice = List.generate(10, (index) => 0);
  final minusCheck = List.generate(10, (index) => false);

  return SpendTimePlaceNotifier(
    SpendTimePlacesResponseState(
      spendTime: spendTime,
      spendPlace: spendPlace,
      spendItem: spendItem,
      spendPrice: spendPrice,
      minusCheck: minusCheck,
    ),
  );
});

class SpendTimePlaceNotifier extends StateNotifier<SpendTimePlacesResponseState> {
  SpendTimePlaceNotifier(super.state);

  ///
  Future<void> setBaseDiff({required String baseDiff}) async => state = state.copyWith(baseDiff: baseDiff);

  ///
  Future<void> setBlinkingFlag({required bool blinkingFlag}) async =>
      state = state.copyWith(blinkingFlag: blinkingFlag);

  ///
  Future<void> setItemPos({required int pos}) async => state = state.copyWith(itemPos: pos);

  ///
  Future<void> setSpendItem({required int pos, required String item}) async {
    final spendItem = <String>[...state.spendItem];

    spendItem[pos] = item;

    state = state.copyWith(spendItem: spendItem);
  }

  ///
  Future<void> setTime({required int pos, required String time}) async {
    final spendTime = <String>[...state.spendTime];
    spendTime[pos] = time;
    state = state.copyWith(spendTime: spendTime);
  }

  ///
  Future<void> setMinusCheck({required int pos}) async {
    final minusChecks = <bool>[...state.minusCheck];
    final check = minusChecks[pos];
    minusChecks[pos] = !check;
    state = state.copyWith(minusCheck: minusChecks);
  }

  ///
  Future<void> setPlace({required int pos, required String place}) async {
    final spendPlace = <String>[...state.spendPlace];
    spendPlace[pos] = place;
    state = state.copyWith(spendPlace: spendPlace);
  }

  ///
  Future<void> setSpendPrice({required int pos, required int price}) async {
    final spendPrice = <int>[...state.spendPrice];
    spendPrice[pos] = price;

    var sum = 0;
    for (var i = 0; i < spendPrice.length; i++) {
      if (state.minusCheck[i]) {
        sum -= spendPrice[i];
      } else {
        sum += spendPrice[i];
      }
    }

    final baseDiff = state.baseDiff.toInt();
    final diff = baseDiff - sum;

    state = state.copyWith(spendPrice: spendPrice, diff: diff);
  }

  // ///
  // Future<void> deleteSpendTimePlaceList({required String date}) async {
  //   final spendTimePlaceList = state.spendTimePlaceList.value!;
  //
  //   spendTimePlaceList.where((element) => element.date == date).toList().forEach((element) {
  //     try {
  //       spendTimePlaceList.removeAt(element.id!);
  //       // ignore: avoid_catches_without_on_clauses, empty_catches
  //     } catch (e) {}
  //   });
  //
  //   state = state.copyWith(spendTimePlaceList: AsyncValue.data(spendTimePlaceList));
  // }

  ///
  Future<void> clearInputValue() async {
    final spendTime = List.generate(10, (index) => '時間');
    final spendPlace = List.generate(10, (index) => '');
    final spendItem = List.generate(10, (index) => '項目名');
    final spendPrice = List.generate(10, (index) => 0);
    final minusCheck = List.generate(10, (index) => false);

    state = state.copyWith(
      spendTime: spendTime,
      spendPlace: spendPlace,
      spendItem: spendItem,
      spendPrice: spendPrice,
      minusCheck: minusCheck,
      itemPos: 0,
      baseDiff: '',
      diff: 0,
    );
  }

  // ///
  // Future<void> setSpendTimePlaceList({required List<SpendTimePlace> spendTimePlaceList}) async =>
  //     state = state.copyWith(spendTimePlaceList: AsyncValue.data(spendTimePlaceList));
  //
  // ///
  // Future<void> setMonthlySpendItemSumMap({required List<SpendTimePlace> spendTimePlaceList}) async {
  //   final monthlySpendItemSumMap = <String, int>{};
  //
  //   final list = <String>[];
  //   SpendType.values.forEach((element) => list.add(element.japanName!));
  //
  //   final map = <String, List<int>>{};
  //
  //   list.forEach((element) {
  //     final filtered = spendTimePlaceList.where((element2) => element2.spendType == element).toList();
  //     if (filtered.isNotEmpty) {
  //       filtered
  //         ..forEach((element3) => map[element3.spendType] = [])
  //         ..forEach((element3) => map[element3.spendType]?.add(element3.price));
  //     }
  //   });
  //
  //   map.forEach((key, value) {
  //     var sum = 0;
  //     value.forEach((element) => sum += element);
  //     monthlySpendItemSumMap[key] = sum;
  //   });
  //
  //   state = state.copyWith(monthlySpendItemSumMap: AsyncValue.data(monthlySpendItemSumMap));
  // }

  ///
  Future<void> clearOneBox({required int pos}) async {
    final spendItem = <String>[...state.spendItem];
    final spendTime = <String>[...state.spendTime];
    final spendPrice = <int>[...state.spendPrice];
    final spendPlace = <String>[...state.spendPlace];
    final minusChecks = <bool>[...state.minusCheck];

    spendItem[pos] = '項目名';
    spendTime[pos] = '時間';
    spendPrice[pos] = 0;
    spendPlace[pos] = '';
    minusChecks[pos] = false;

    state = state.copyWith(
      spendTime: spendTime,
      spendPlace: spendPlace,
      spendItem: spendItem,
      spendPrice: spendPrice,
      minusCheck: minusChecks,
    );
  }

// ///
// Future<void> setUpdateSpendTimePlace({required List<SpendTimePlace> updateSpendTimePlace}) async {
//   final spendItem = <String>[...state.spendItem];
//   final spendTime = <String>[...state.spendTime];
//   final spendPrice = <int>[...state.spendPrice];
//   final spendPlace = <String>[...state.spendPlace];
//   final minusChecks = <bool>[...state.minusCheck];
//
//   for (var i = 0; i < updateSpendTimePlace.length; i++) {
//     spendItem[i] = updateSpendTimePlace[i].spendType;
//     spendTime[i] = updateSpendTimePlace[i].time;
//     spendPlace[i] = updateSpendTimePlace[i].place;
//
//     if (updateSpendTimePlace[i].price < 0) {
//       spendPrice[i] = updateSpendTimePlace[i].price * -1;
//       minusChecks[i] = true;
//     } else {
//       spendPrice[i] = updateSpendTimePlace[i].price;
//       minusChecks[i] = false;
//     }
//   }
//
//   state = state.copyWith(
//     spendTime: spendTime,
//     spendPlace: spendPlace,
//     spendItem: spendItem,
//     spendPrice: spendPrice,
//     minusCheck: minusChecks,
//   );
// }
}
