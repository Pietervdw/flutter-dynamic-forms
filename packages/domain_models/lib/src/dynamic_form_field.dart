import 'package:json_annotation/json_annotation.dart';

import '../domain_models.dart';

part 'dynamic_form_field.g.dart';

@JsonSerializable()
class DynamicFormField {
  final String type;
  final String label;
  final String key;
  final List<String>? options;
  final DynamicFormFieldValidation validations;

  DynamicFormField({
    required this.type,
    required this.label,
    required this.key,
    required this.options,
    required this.validations,
  });

  factory DynamicFormField.fromJson(Map<String, dynamic> json) => _$DynamicFormFieldFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicFormFieldToJson(this);
}
