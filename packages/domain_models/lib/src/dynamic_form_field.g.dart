// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_form_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicFormField _$DynamicFormFieldFromJson(Map<String, dynamic> json) =>
    DynamicFormField(
      type: json['type'] as String,
      label: json['label'] as String,
      key: json['key'] as String,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      validations: DynamicFormFieldValidation.fromJson(
          json['validations'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DynamicFormFieldToJson(DynamicFormField instance) =>
    <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'key': instance.key,
      'options': instance.options,
      'validations': instance.validations,
    };
