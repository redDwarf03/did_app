// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_identity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublicIdentityModelImpl _$$PublicIdentityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PublicIdentityModelImpl(
      address: json['address'] as String,
      name: json['name'] as String,
      publicName: json['publicName'] as String?,
      profileImage: json['profileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => IdentityService.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PublicIdentityModelImplToJson(
        _$PublicIdentityModelImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'publicName': instance.publicName,
      'profileImage': instance.profileImage,
      'createdAt': instance.createdAt.toIso8601String(),
      'services': instance.services,
    };

_$IdentityServiceImpl _$$IdentityServiceImplFromJson(
        Map<String, dynamic> json) =>
    _$IdentityServiceImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      endpoint: json['endpoint'] as String,
    );

Map<String, dynamic> _$$IdentityServiceImplToJson(
        _$IdentityServiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'endpoint': instance.endpoint,
    };
