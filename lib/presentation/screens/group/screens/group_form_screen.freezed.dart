// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_form_screen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupFromState {
  String? get title;

  /// Create a copy of GroupFromState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GroupFromStateCopyWith<GroupFromState> get copyWith =>
      _$GroupFromStateCopyWithImpl<GroupFromState>(
          this as GroupFromState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GroupFromState &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title);

  @override
  String toString() {
    return 'GroupFromState(title: $title)';
  }
}

/// @nodoc
abstract mixin class $GroupFromStateCopyWith<$Res> {
  factory $GroupFromStateCopyWith(
          GroupFromState value, $Res Function(GroupFromState) _then) =
      _$GroupFromStateCopyWithImpl;
  @useResult
  $Res call({String? title});
}

/// @nodoc
class _$GroupFromStateCopyWithImpl<$Res>
    implements $GroupFromStateCopyWith<$Res> {
  _$GroupFromStateCopyWithImpl(this._self, this._then);

  final GroupFromState _self;
  final $Res Function(GroupFromState) _then;

  /// Create a copy of GroupFromState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_self.copyWith(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _GroupFromState implements GroupFromState {
  _GroupFromState({this.title});

  @override
  final String? title;

  /// Create a copy of GroupFromState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GroupFromStateCopyWith<_GroupFromState> get copyWith =>
      __$GroupFromStateCopyWithImpl<_GroupFromState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupFromState &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title);

  @override
  String toString() {
    return 'GroupFromState(title: $title)';
  }
}

/// @nodoc
abstract mixin class _$GroupFromStateCopyWith<$Res>
    implements $GroupFromStateCopyWith<$Res> {
  factory _$GroupFromStateCopyWith(
          _GroupFromState value, $Res Function(_GroupFromState) _then) =
      __$GroupFromStateCopyWithImpl;
  @override
  @useResult
  $Res call({String? title});
}

/// @nodoc
class __$GroupFromStateCopyWithImpl<$Res>
    implements _$GroupFromStateCopyWith<$Res> {
  __$GroupFromStateCopyWithImpl(this._self, this._then);

  final _GroupFromState _self;
  final $Res Function(_GroupFromState) _then;

  /// Create a copy of GroupFromState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_GroupFromState(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
