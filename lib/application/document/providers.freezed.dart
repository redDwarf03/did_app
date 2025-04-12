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
mixin _$DocumentState {
  /// List of documents owned by the user.
  List<Document> get documents => throw _privateConstructorUsedError;

  /// The currently selected document (e.g., for viewing details).
  Document? get selectedDocument => throw _privateConstructorUsedError;

  /// Indicates if a document-related operation is in progress.
  bool get isLoading => throw _privateConstructorUsedError;

  /// Holds a potential error message from the last operation.
  String? get errorMessage => throw _privateConstructorUsedError;

  /// List of versions for the [selectedDocument].
  List<DocumentVersion> get documentVersions =>
      throw _privateConstructorUsedError;

  /// The currently selected version of the [selectedDocument].
  DocumentVersion? get selectedVersion => throw _privateConstructorUsedError;

  /// List of shares created by the user for the [selectedDocument].
  List<DocumentShare> get documentShares => throw _privateConstructorUsedError;

  /// List of documents shared with the current user by others.
  List<DocumentShare> get sharedWithMe => throw _privateConstructorUsedError;

  /// Create a copy of DocumentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentStateCopyWith<DocumentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentStateCopyWith<$Res> {
  factory $DocumentStateCopyWith(
          DocumentState value, $Res Function(DocumentState) then) =
      _$DocumentStateCopyWithImpl<$Res, DocumentState>;
  @useResult
  $Res call(
      {List<Document> documents,
      Document? selectedDocument,
      bool isLoading,
      String? errorMessage,
      List<DocumentVersion> documentVersions,
      DocumentVersion? selectedVersion,
      List<DocumentShare> documentShares,
      List<DocumentShare> sharedWithMe});

  $DocumentCopyWith<$Res>? get selectedDocument;
  $DocumentVersionCopyWith<$Res>? get selectedVersion;
}

/// @nodoc
class _$DocumentStateCopyWithImpl<$Res, $Val extends DocumentState>
    implements $DocumentStateCopyWith<$Res> {
  _$DocumentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documents = null,
    Object? selectedDocument = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? documentVersions = null,
    Object? selectedVersion = freezed,
    Object? documentShares = null,
    Object? sharedWithMe = null,
  }) {
    return _then(_value.copyWith(
      documents: null == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<Document>,
      selectedDocument: freezed == selectedDocument
          ? _value.selectedDocument
          : selectedDocument // ignore: cast_nullable_to_non_nullable
              as Document?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      documentVersions: null == documentVersions
          ? _value.documentVersions
          : documentVersions // ignore: cast_nullable_to_non_nullable
              as List<DocumentVersion>,
      selectedVersion: freezed == selectedVersion
          ? _value.selectedVersion
          : selectedVersion // ignore: cast_nullable_to_non_nullable
              as DocumentVersion?,
      documentShares: null == documentShares
          ? _value.documentShares
          : documentShares // ignore: cast_nullable_to_non_nullable
              as List<DocumentShare>,
      sharedWithMe: null == sharedWithMe
          ? _value.sharedWithMe
          : sharedWithMe // ignore: cast_nullable_to_non_nullable
              as List<DocumentShare>,
    ) as $Val);
  }

  /// Create a copy of DocumentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DocumentCopyWith<$Res>? get selectedDocument {
    if (_value.selectedDocument == null) {
      return null;
    }

    return $DocumentCopyWith<$Res>(_value.selectedDocument!, (value) {
      return _then(_value.copyWith(selectedDocument: value) as $Val);
    });
  }

  /// Create a copy of DocumentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DocumentVersionCopyWith<$Res>? get selectedVersion {
    if (_value.selectedVersion == null) {
      return null;
    }

    return $DocumentVersionCopyWith<$Res>(_value.selectedVersion!, (value) {
      return _then(_value.copyWith(selectedVersion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DocumentStateImplCopyWith<$Res>
    implements $DocumentStateCopyWith<$Res> {
  factory _$$DocumentStateImplCopyWith(
          _$DocumentStateImpl value, $Res Function(_$DocumentStateImpl) then) =
      __$$DocumentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Document> documents,
      Document? selectedDocument,
      bool isLoading,
      String? errorMessage,
      List<DocumentVersion> documentVersions,
      DocumentVersion? selectedVersion,
      List<DocumentShare> documentShares,
      List<DocumentShare> sharedWithMe});

  @override
  $DocumentCopyWith<$Res>? get selectedDocument;
  @override
  $DocumentVersionCopyWith<$Res>? get selectedVersion;
}

/// @nodoc
class __$$DocumentStateImplCopyWithImpl<$Res>
    extends _$DocumentStateCopyWithImpl<$Res, _$DocumentStateImpl>
    implements _$$DocumentStateImplCopyWith<$Res> {
  __$$DocumentStateImplCopyWithImpl(
      _$DocumentStateImpl _value, $Res Function(_$DocumentStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documents = null,
    Object? selectedDocument = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? documentVersions = null,
    Object? selectedVersion = freezed,
    Object? documentShares = null,
    Object? sharedWithMe = null,
  }) {
    return _then(_$DocumentStateImpl(
      documents: null == documents
          ? _value._documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<Document>,
      selectedDocument: freezed == selectedDocument
          ? _value.selectedDocument
          : selectedDocument // ignore: cast_nullable_to_non_nullable
              as Document?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      documentVersions: null == documentVersions
          ? _value._documentVersions
          : documentVersions // ignore: cast_nullable_to_non_nullable
              as List<DocumentVersion>,
      selectedVersion: freezed == selectedVersion
          ? _value.selectedVersion
          : selectedVersion // ignore: cast_nullable_to_non_nullable
              as DocumentVersion?,
      documentShares: null == documentShares
          ? _value._documentShares
          : documentShares // ignore: cast_nullable_to_non_nullable
              as List<DocumentShare>,
      sharedWithMe: null == sharedWithMe
          ? _value._sharedWithMe
          : sharedWithMe // ignore: cast_nullable_to_non_nullable
              as List<DocumentShare>,
    ));
  }
}

/// @nodoc

class _$DocumentStateImpl implements _DocumentState {
  const _$DocumentStateImpl(
      {final List<Document> documents = const [],
      this.selectedDocument,
      this.isLoading = false,
      this.errorMessage,
      final List<DocumentVersion> documentVersions = const [],
      this.selectedVersion,
      final List<DocumentShare> documentShares = const [],
      final List<DocumentShare> sharedWithMe = const []})
      : _documents = documents,
        _documentVersions = documentVersions,
        _documentShares = documentShares,
        _sharedWithMe = sharedWithMe;

  /// List of documents owned by the user.
  final List<Document> _documents;

  /// List of documents owned by the user.
  @override
  @JsonKey()
  List<Document> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  /// The currently selected document (e.g., for viewing details).
  @override
  final Document? selectedDocument;

  /// Indicates if a document-related operation is in progress.
  @override
  @JsonKey()
  final bool isLoading;

  /// Holds a potential error message from the last operation.
  @override
  final String? errorMessage;

  /// List of versions for the [selectedDocument].
  final List<DocumentVersion> _documentVersions;

  /// List of versions for the [selectedDocument].
  @override
  @JsonKey()
  List<DocumentVersion> get documentVersions {
    if (_documentVersions is EqualUnmodifiableListView)
      return _documentVersions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documentVersions);
  }

  /// The currently selected version of the [selectedDocument].
  @override
  final DocumentVersion? selectedVersion;

  /// List of shares created by the user for the [selectedDocument].
  final List<DocumentShare> _documentShares;

  /// List of shares created by the user for the [selectedDocument].
  @override
  @JsonKey()
  List<DocumentShare> get documentShares {
    if (_documentShares is EqualUnmodifiableListView) return _documentShares;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documentShares);
  }

  /// List of documents shared with the current user by others.
  final List<DocumentShare> _sharedWithMe;

  /// List of documents shared with the current user by others.
  @override
  @JsonKey()
  List<DocumentShare> get sharedWithMe {
    if (_sharedWithMe is EqualUnmodifiableListView) return _sharedWithMe;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWithMe);
  }

  @override
  String toString() {
    return 'DocumentState(documents: $documents, selectedDocument: $selectedDocument, isLoading: $isLoading, errorMessage: $errorMessage, documentVersions: $documentVersions, selectedVersion: $selectedVersion, documentShares: $documentShares, sharedWithMe: $sharedWithMe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentStateImpl &&
            const DeepCollectionEquality()
                .equals(other._documents, _documents) &&
            (identical(other.selectedDocument, selectedDocument) ||
                other.selectedDocument == selectedDocument) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._documentVersions, _documentVersions) &&
            (identical(other.selectedVersion, selectedVersion) ||
                other.selectedVersion == selectedVersion) &&
            const DeepCollectionEquality()
                .equals(other._documentShares, _documentShares) &&
            const DeepCollectionEquality()
                .equals(other._sharedWithMe, _sharedWithMe));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_documents),
      selectedDocument,
      isLoading,
      errorMessage,
      const DeepCollectionEquality().hash(_documentVersions),
      selectedVersion,
      const DeepCollectionEquality().hash(_documentShares),
      const DeepCollectionEquality().hash(_sharedWithMe));

  /// Create a copy of DocumentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentStateImplCopyWith<_$DocumentStateImpl> get copyWith =>
      __$$DocumentStateImplCopyWithImpl<_$DocumentStateImpl>(this, _$identity);
}

abstract class _DocumentState implements DocumentState {
  const factory _DocumentState(
      {final List<Document> documents,
      final Document? selectedDocument,
      final bool isLoading,
      final String? errorMessage,
      final List<DocumentVersion> documentVersions,
      final DocumentVersion? selectedVersion,
      final List<DocumentShare> documentShares,
      final List<DocumentShare> sharedWithMe}) = _$DocumentStateImpl;

  /// List of documents owned by the user.
  @override
  List<Document> get documents;

  /// The currently selected document (e.g., for viewing details).
  @override
  Document? get selectedDocument;

  /// Indicates if a document-related operation is in progress.
  @override
  bool get isLoading;

  /// Holds a potential error message from the last operation.
  @override
  String? get errorMessage;

  /// List of versions for the [selectedDocument].
  @override
  List<DocumentVersion> get documentVersions;

  /// The currently selected version of the [selectedDocument].
  @override
  DocumentVersion? get selectedVersion;

  /// List of shares created by the user for the [selectedDocument].
  @override
  List<DocumentShare> get documentShares;

  /// List of documents shared with the current user by others.
  @override
  List<DocumentShare> get sharedWithMe;

  /// Create a copy of DocumentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentStateImplCopyWith<_$DocumentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
