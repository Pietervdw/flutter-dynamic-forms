// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicForm _$DynamicFormFromJson(Map<String, dynamic> json) => DynamicForm(
      id: json['id'] as int,
      name: json['name'] as String,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => DynamicFormField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DynamicFormToJson(DynamicForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fields': instance.fields,
    };
