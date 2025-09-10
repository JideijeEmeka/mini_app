// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Business _$BusinessFromJson(Map<String, dynamic> json) => Business(
      name: json['name'] as String,
      location: json['location'] as String,
      contactNumber: json['contactNumber'] as String,
    );

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'contactNumber': instance.contactNumber,
    };
