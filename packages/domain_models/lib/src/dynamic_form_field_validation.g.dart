// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_form_field_validation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicFormFieldValidation _$DynamicFormFieldValidationFromJson(
        Map<String, dynamic> json) =>
    DynamicFormFieldValidation(
      required: json['required'] as bool,
      minLength: json['minLength'] as int?,
      maxLength: json['maxLength'] as int?,
      email: json['email'] as bool?,
      numeric: json['numeric'] as bool?,
    );

Map<String, dynamic> _$DynamicFormFieldValidationToJson(
        DynamicFormFieldValidation instance) =>
    <String, dynamic>{
      'required': instance.required,
      'minLength': instance.minLength,
      'maxLength': instance.maxLength,
      'email': instance.email,
      'numeric': instance.numeric,
    };
