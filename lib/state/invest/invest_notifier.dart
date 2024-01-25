import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'invest_response_state.dart';

//===============================

final investProvider = StateNotifierProvider.autoDispose<InvestNotifier, InvestResponseState>((ref) {
  return InvestNotifier(const InvestResponseState());
});

class InvestNotifier extends StateNotifier<InvestResponseState> {
  InvestNotifier(super.state);

  ///
  Future<void> setSelectedInvestItem({required String item}) async => state = state.copyWith(selectedInvestItem: item);
}

//===============================

final investInputProvider =
    StateNotifierProvider.autoDispose.family<InvestInputNotifier, InvestResponseState, int>((ref, investNum) {
  final investIdList = List.generate(investNum, (index) => 0);
  final investPriceList = List.generate(investNum, (index) => 0);

  return InvestInputNotifier(InvestResponseState(investIdList: investIdList, investPriceList: investPriceList));
});

class InvestInputNotifier extends StateNotifier<InvestResponseState> {
  InvestInputNotifier(super.state);

  ///
  Future<void> setInvestInputDate({required String date}) async => state = state.copyWith(investInputDate: date);

  ///
  Future<void> setInputInvestValue({required int pos, required int id, required int price}) async {
    final investIdList = [...state.investIdList];
    final investPriceList = [...state.investPriceList];

    investIdList[pos] = id;
    investPriceList[pos] = price;

    state = state.copyWith(investIdList: investIdList, investPriceList: investPriceList);
  }

  ///
  Future<void> clearInputInvestValue({required int investNum}) async {
    final investIdList = List.generate(investNum, (index) => 0);
    final investPriceList = List.generate(investNum, (index) => 0);

    state = state.copyWith(investIdList: investIdList, investPriceList: investPriceList);
  }
}

//===============================
