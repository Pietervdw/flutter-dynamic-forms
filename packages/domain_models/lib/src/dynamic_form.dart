import 'package:json_annotation/json_annotation.dart';

import '../domain_models.dart';

part 'dynamic_form.g.dart';

@JsonSerializable()
class DynamicForm {
  final int id;
  final String name;
  final List<DynamicFormField> fields;

  DynamicForm({
    required this.id,
    required this.name,
    required this.fields,
  });

  factory DynamicForm.fromJson(Map<String, dynamic> json) => _$DynamicFormFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicFormToJson(this);
}
