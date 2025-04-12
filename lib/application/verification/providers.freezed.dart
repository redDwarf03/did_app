// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VerificationState {
  /// The ongoing or completed verification process details.
  VerificationProcess? get verificationProcess =>
      throw _privateConstructorUsedError;

  /// Indicates if a verification operation (load, start, submit) is in progress.
  bool get isLoading => throw _privateConstructorUsedError;

  /// Holds a potential error message from the last verification operation.
  String? get errorMessage => throw _privateConstructorUsedError;

  /// The index of the current step within the [verificationProcess.steps] list
  /// that the user is actively working on or needs to complete.
  int get currentStepIndex => throw _privateConstructorUsedError;

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerificationStateCopyWith<VerificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationStateCopyWith<$Res> {
  factory $VerificationStateCopyWith(
          VerificationState value, $Res Function(VerificationState) then) =
      _$VerificationStateCopyWithImpl<$Res, VerificationState>;
  @useResult
  $Res call(
      {VerificationProcess? verificationProcess,
      bool isLoading,
      String? errorMessage,
      int currentStepIndex});

  $VerificationProcessCopyWith<$Res>? get verificationProcess;
}

/// @nodoc
class _$VerificationStateCopyWithImpl<$Res, $Val extends VerificationState>
    implements $VerificationStateCopyWith<$Res> {
  _$VerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationProcess = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? currentStepIndex = null,
  }) {
    return _then(_value.copyWith(
      verificationProcess: freezed == verificationProcess
          ? _value.verificationProcess
          : verificationProcess // ignore: cast_nullable_to_non_nullable
              as VerificationProcess?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStepIndex: null == currentStepIndex
          ? _value.currentStepIndex
          : currentStepIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerificationProcessCopyWith<$Res>? get verificationProcess {
    if (_value.verificationProcess == null) {
      return null;
    }

    return $VerificationProcessCopyWith<$Res>(_value.verificationProcess!,
        (value) {
      return _then(_value.copyWith(verificationProcess: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VerificationStateImplCopyWith<$Res>
    implements $VerificationStateCopyWith<$Res> {
  factory _$$VerificationStateImplCopyWith(_$VerificationStateImpl value,
          $Res Function(_$VerificationStateImpl) then) =
      __$$VerificationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {VerificationProcess? verificationProcess,
      bool isLoading,
      String? errorMessage,
      int currentStepIndex});

  @override
  $VerificationProcessCopyWith<$Res>? get verificationProcess;
}

/// @nodoc
class __$$VerificationStateImplCopyWithImpl<$Res>
    extends _$VerificationStateCopyWithImpl<$Res, _$VerificationStateImpl>
    implements _$$VerificationStateImplCopyWith<$Res> {
  __$$VerificationStateImplCopyWithImpl(_$VerificationStateImpl _value,
      $Res Function(_$VerificationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationProcess = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? currentStepIndex = null,
  }) {
    return _then(_$VerificationStateImpl(
      verificationProcess: freezed == verificationProcess
          ? _value.verificationProcess
          : verificationProcess // ignore: cast_nullable_to_non_nullable
              as VerificationProcess?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStepIndex: null == currentStepIndex
          ? _value.currentStepIndex
          : currentStepIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$VerificationStateImpl extends _VerificationState {
  const _$VerificationStateImpl(
      {this.verificationProcess,
      this.isLoading = false,
      this.errorMessage,
      this.currentStepIndex = 0})
      : super._();

  /// The ongoing or completed verification process details.
  @override
  final VerificationProcess? verificationProcess;

  /// Indicates if a verification operation (load, start, submit) is in progress.
  @override
  @JsonKey()
  final bool isLoading;

  /// Holds a potential error message from the last verification operation.
  @override
  final String? errorMessage;

  /// The index of the current step within the [verificationProcess.steps] list
  /// that the user is actively working on or needs to complete.
  @override
  @JsonKey()
  final int currentStepIndex;

  @override
  String toString() {
    return 'VerificationState(verificationProcess: $verificationProcess, isLoading: $isLoading, errorMessage: $errorMessage, currentStepIndex: $currentStepIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationStateImpl &&
            (identical(other.verificationProcess, verificationProcess) ||
                other.verificationProcess == verificationProcess) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.currentStepIndex, currentStepIndex) ||
                other.currentStepIndex == currentStepIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, verificationProcess, isLoading,
      errorMessage, currentStepIndex);

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationStateImplCopyWith<_$VerificationStateImpl> get copyWith =>
      __$$VerificationStateImplCopyWithImpl<_$VerificationStateImpl>(
          this, _$identity);
}

abstract class _VerificationState extends VerificationState {
  const factory _VerificationState(
      {final VerificationProcess? verificationProcess,
      final bool isLoading,
      final String? errorMessage,
      final int currentStepIndex}) = _$VerificationStateImpl;
  const _VerificationState._() : super._();

  /// The ongoing or completed verification process details.
  @override
  VerificationProcess? get verificationProcess;

  /// Indicates if a verification operation (load, start, submit) is in progress.
  @override
  bool get isLoading;

  /// Holds a potential error message from the last verification operation.
  @override
  String? get errorMessage;

  /// The index of the current step within the [verificationProcess.steps] list
  /// that the user is actively working on or needs to complete.
  @override
  int get currentStepIndex;

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationStateImplCopyWith<_$VerificationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
