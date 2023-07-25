import 'package:json_annotation/json_annotation.dart';

part 'dynamic_form_field_validation.g.dart';

@JsonSerializable()
class DynamicFormFieldValidation {
  final bool required;
  final int? minLength;
  final int? maxLength;
  final bool? email;
  final bool? numeric;

  DynamicFormFieldValidation({
    required this.required,
    required this.minLength,
    required this.maxLength,
    required this.email,
    required this.numeric,
  });

  factory DynamicFormFieldValidation.fromJson(Map<String, dynamic> json) => _$DynamicFormFieldValidationFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicFormFieldValidationToJson(this);
}
