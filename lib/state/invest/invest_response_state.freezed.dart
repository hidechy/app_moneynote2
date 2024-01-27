// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invest_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InvestResponseState {
  String get selectedInvestItem => throw _privateConstructorUsedError;

  ///
  List<int> get investIdList => throw _privateConstructorUsedError;
  List<int> get investPriceList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InvestResponseStateCopyWith<InvestResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvestResponseStateCopyWith<$Res> {
  factory $InvestResponseStateCopyWith(
          InvestResponseState value, $Res Function(InvestResponseState) then) =
      _$InvestResponseStateCopyWithImpl<$Res, InvestResponseState>;
  @useResult
  $Res call(
      {String selectedInvestItem,
      List<int> investIdList,
      List<int> investPriceList});
}

/// @nodoc
class _$InvestResponseStateCopyWithImpl<$Res, $Val extends InvestResponseState>
    implements $InvestResponseStateCopyWith<$Res> {
  _$InvestResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedInvestItem = null,
    Object? investIdList = null,
    Object? investPriceList = null,
  }) {
    return _then(_value.copyWith(
      selectedInvestItem: null == selectedInvestItem
          ? _value.selectedInvestItem
          : selectedInvestItem // ignore: cast_nullable_to_non_nullable
              as String,
      investIdList: null == investIdList
          ? _value.investIdList
          : investIdList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      investPriceList: null == investPriceList
          ? _value.investPriceList
          : investPriceList // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvestResponseStateImplCopyWith<$Res>
    implements $InvestResponseStateCopyWith<$Res> {
  factory _$$InvestResponseStateImplCopyWith(_$InvestResponseStateImpl value,
          $Res Function(_$InvestResponseStateImpl) then) =
      __$$InvestResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String selectedInvestItem,
      List<int> investIdList,
      List<int> investPriceList});
}

/// @nodoc
class __$$InvestResponseStateImplCopyWithImpl<$Res>
    extends _$InvestResponseStateCopyWithImpl<$Res, _$InvestResponseStateImpl>
    implements _$$InvestResponseStateImplCopyWith<$Res> {
  __$$InvestResponseStateImplCopyWithImpl(_$InvestResponseStateImpl _value,
      $Res Function(_$InvestResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedInvestItem = null,
    Object? investIdList = null,
    Object? investPriceList = null,
  }) {
    return _then(_$InvestResponseStateImpl(
      selectedInvestItem: null == selectedInvestItem
          ? _value.selectedInvestItem
          : selectedInvestItem // ignore: cast_nullable_to_non_nullable
              as String,
      investIdList: null == investIdList
          ? _value._investIdList
          : investIdList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      investPriceList: null == investPriceList
          ? _value._investPriceList
          : investPriceList // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$InvestResponseStateImpl implements _InvestResponseState {
  const _$InvestResponseStateImpl(
      {this.selectedInvestItem = '',
      final List<int> investIdList = const [],
      final List<int> investPriceList = const []})
      : _investIdList = investIdList,
        _investPriceList = investPriceList;

  @override
  @JsonKey()
  final String selectedInvestItem;

  ///
  final List<int> _investIdList;

  ///
  @override
  @JsonKey()
  List<int> get investIdList {
    if (_investIdList is EqualUnmodifiableListView) return _investIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_investIdList);
  }

  final List<int> _investPriceList;
  @override
  @JsonKey()
  List<int> get investPriceList {
    if (_investPriceList is EqualUnmodifiableListView) return _investPriceList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_investPriceList);
  }

  @override
  String toString() {
    return 'InvestResponseState(selectedInvestItem: $selectedInvestItem, investIdList: $investIdList, investPriceList: $investPriceList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvestResponseStateImpl &&
            (identical(other.selectedInvestItem, selectedInvestItem) ||
                other.selectedInvestItem == selectedInvestItem) &&
            const DeepCollectionEquality()
                .equals(other._investIdList, _investIdList) &&
            const DeepCollectionEquality()
                .equals(other._investPriceList, _investPriceList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedInvestItem,
      const DeepCollectionEquality().hash(_investIdList),
      const DeepCollectionEquality().hash(_investPriceList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvestResponseStateImplCopyWith<_$InvestResponseStateImpl> get copyWith =>
      __$$InvestResponseStateImplCopyWithImpl<_$InvestResponseStateImpl>(
          this, _$identity);
}

abstract class _InvestResponseState implements InvestResponseState {
  const factory _InvestResponseState(
      {final String selectedInvestItem,
      final List<int> investIdList,
      final List<int> investPriceList}) = _$InvestResponseStateImpl;

  @override
  String get selectedInvestItem;
  @override

  ///
  List<int> get investIdList;
  @override
  List<int> get investPriceList;
  @override
  @JsonKey(ignore: true)
  _$$InvestResponseStateImplCopyWith<_$InvestResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
