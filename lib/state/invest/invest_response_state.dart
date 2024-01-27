import 'package:freezed_annotation/freezed_annotation.dart';

part 'invest_response_state.freezed.dart';

@freezed
class InvestResponseState with _$InvestResponseState {
  const factory InvestResponseState({
    @Default('') String selectedInvestItem,

    ///
    @Default([]) List<int> investIdList,
    @Default([]) List<int> investPriceList,
  }) = _InvestResponseState;
}
