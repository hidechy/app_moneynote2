import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'invest_response_state.dart';

final investProvider = StateNotifierProvider.autoDispose<InvestNotifier, InvestResponseState>((ref) {
  return InvestNotifier(const InvestResponseState());
});

class InvestNotifier extends StateNotifier<InvestResponseState> {
  InvestNotifier(super.state);

  ///
  Future<void> setSelectedInvestItem({required String item}) async => state = state.copyWith(selectedInvestItem: item);
}
