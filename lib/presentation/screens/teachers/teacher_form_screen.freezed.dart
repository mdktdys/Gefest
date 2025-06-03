// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher_form_screen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TeacherFormState {
  String? get title;
  String? get image;

  /// Create a copy of TeacherFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TeacherFormStateCopyWith<TeacherFormState> get copyWith =>
      _$TeacherFormStateCopyWithImpl<TeacherFormState>(
          this as TeacherFormState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TeacherFormState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, image);

  @override
  String toString() {
    return 'TeacherFormState(title: $title, image: $image)';
  }
}

/// @nodoc
abstract mixin class $TeacherFormStateCopyWith<$Res> {
  factory $TeacherFormStateCopyWith(
          TeacherFormState value, $Res Function(TeacherFormState) _then) =
      _$TeacherFormStateCopyWithImpl;
  @useResult
  $Res call({String? title, String? image});
}

/// @nodoc
class _$TeacherFormStateCopyWithImpl<$Res>
    implements $TeacherFormStateCopyWith<$Res> {
  _$TeacherFormStateCopyWithImpl(this._self, this._then);

  final TeacherFormState _self;
  final $Res Function(TeacherFormState) _then;

  /// Create a copy of TeacherFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? image = freezed,
  }) {
    return _then(_self.copyWith(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _TeacherFormState implements TeacherFormState {
  _TeacherFormState({this.title, this.image});

  @override
  final String? title;
  @override
  final String? image;

  /// Create a copy of TeacherFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TeacherFormStateCopyWith<_TeacherFormState> get copyWith =>
      __$TeacherFormStateCopyWithImpl<_TeacherFormState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TeacherFormState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, image);

  @override
  String toString() {
    return 'TeacherFormState(title: $title, image: $image)';
  }
}

/// @nodoc
abstract mixin class _$TeacherFormStateCopyWith<$Res>
    implements $TeacherFormStateCopyWith<$Res> {
  factory _$TeacherFormStateCopyWith(
          _TeacherFormState value, $Res Function(_TeacherFormState) _then) =
      __$TeacherFormStateCopyWithImpl;
  @override
  @useResult
  $Res call({String? title, String? image});
}

/// @nodoc
class __$TeacherFormStateCopyWithImpl<$Res>
    implements _$TeacherFormStateCopyWith<$Res> {
  __$TeacherFormStateCopyWithImpl(this._self, this._then);

  final _TeacherFormState _self;
  final $Res Function(_TeacherFormState) _then;

  /// Create a copy of TeacherFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
    Object? image = freezed,
  }) {
    return _then(_TeacherFormState(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
