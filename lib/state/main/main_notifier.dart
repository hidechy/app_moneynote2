import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import 'main_response_state.dart';

final mainProvider = StateNotifierProvider.autoDispose<MainNotifier, MainResponseState>((ref) {
  return MainNotifier(const MainResponseState());
});

class MainNotifier extends StateNotifier<MainResponseState> {
  MainNotifier(super.state);

  ///
  Future<void> setIsar({required Isar isar}) async => state = state.copyWith(isar: isar);
}
