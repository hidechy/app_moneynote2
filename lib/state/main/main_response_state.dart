import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'main_response_state.freezed.dart';

@freezed
class MainResponseState with _$MainResponseState {
  const factory MainResponseState({
    Isar? isar,
  }) = _MainResponseState;
}
