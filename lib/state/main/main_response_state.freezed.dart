// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MainResponseState {
  Isar? get isar => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainResponseStateCopyWith<MainResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainResponseStateCopyWith<$Res> {
  factory $MainResponseStateCopyWith(
          MainResponseState value, $Res Function(MainResponseState) then) =
      _$MainResponseStateCopyWithImpl<$Res, MainResponseState>;
  @useResult
  $Res call({Isar? isar});
}

/// @nodoc
class _$MainResponseStateCopyWithImpl<$Res, $Val extends MainResponseState>
    implements $MainResponseStateCopyWith<$Res> {
  _$MainResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isar = freezed,
  }) {
    return _then(_value.copyWith(
      isar: freezed == isar
          ? _value.isar
          : isar // ignore: cast_nullable_to_non_nullable
              as Isar?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainResponseStateImplCopyWith<$Res>
    implements $MainResponseStateCopyWith<$Res> {
  factory _$$MainResponseStateImplCopyWith(_$MainResponseStateImpl value,
          $Res Function(_$MainResponseStateImpl) then) =
      __$$MainResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Isar? isar});
}

/// @nodoc
class __$$MainResponseStateImplCopyWithImpl<$Res>
    extends _$MainResponseStateCopyWithImpl<$Res, _$MainResponseStateImpl>
    implements _$$MainResponseStateImplCopyWith<$Res> {
  __$$MainResponseStateImplCopyWithImpl(_$MainResponseStateImpl _value,
      $Res Function(_$MainResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isar = freezed,
  }) {
    return _then(_$MainResponseStateImpl(
      isar: freezed == isar
          ? _value.isar
          : isar // ignore: cast_nullable_to_non_nullable
              as Isar?,
    ));
  }
}

/// @nodoc

class _$MainResponseStateImpl implements _MainResponseState {
  const _$MainResponseStateImpl({this.isar});

  @override
  final Isar? isar;

  @override
  String toString() {
    return 'MainResponseState(isar: $isar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainResponseStateImpl &&
            (identical(other.isar, isar) || other.isar == isar));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainResponseStateImplCopyWith<_$MainResponseStateImpl> get copyWith =>
      __$$MainResponseStateImplCopyWithImpl<_$MainResponseStateImpl>(
          this, _$identity);
}

abstract class _MainResponseState implements MainResponseState {
  const factory _MainResponseState({final Isar? isar}) =
      _$MainResponseStateImpl;

  @override
  Isar? get isar;
  @override
  @JsonKey(ignore: true)
  _$$MainResponseStateImplCopyWith<_$MainResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
