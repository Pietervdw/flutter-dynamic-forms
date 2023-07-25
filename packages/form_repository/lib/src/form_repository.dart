import 'dart:convert';

import 'package:domain_models/domain_models.dart';

class FormRepository {

  String getJson() {
    String json = '''{
  "id": 1,
  "name": "Contact Details Form",
  "fields": [
    {
      "type": "TextBox",
      "label": "Full Name",
      "key": "fullName",
      "validations": {
        "required": true,
        "minLength": 3,
        "maxLength": 50
      }
    },
    {
      "type": "TextBox",
      "label": "Email",
      "key": "email",
      "validations": {
        "required": true,
        "email": true
      }
    },
    {
      "type": "TextBox",
      "label": "Age",
      "key": "age",
      "validations": {
        "required": false,
        "numeric": true
      }
    },
    {
      "type": "DropdownList",
      "label": "Province",
      "key": "province",
      "options": [
        "Eastern Cape",
        "Free State",
        "Gauteng",
        "KwaZulu-Natal",
        "Limpopo",
        "Mpumalanga",
        "Northern Cape",
        "North West",
        "Western Cape"
      ],
      "validations": {"required": true}
    }
  ]
}''';
    return json;
  }

  Future<DynamicForm> loadForm() async {
    // Simulate loading Time as if calling an API
    await Future.delayed(const Duration(seconds: 3));
    final dynamicForm = DynamicForm.fromJson(jsonDecode(getJson()));
    return dynamicForm;
  }
}
