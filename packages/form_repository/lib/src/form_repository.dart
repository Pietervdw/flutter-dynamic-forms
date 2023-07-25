class FormRepository {
  Future<List<Map<String, dynamic>>> loadForm({required int id}) async {
    // Imitating calling an API to retrieve the form.
    await Future.delayed(const Duration(seconds: 3));
    return [
      {
        "type": "TextBox",
        "label": "Full Name",
        "key": "fullName",
        "validations": {
          "required": true,
          "minLength": 3,
          "maxLength": 50,
        },
      },
      {
        "type": "TextBox",
        "label": "Email",
        "key": "email",
        "validations": {
          "required": true,
          "email": true,
        },
      },
      {
        "type": "TextBox",
        "label": "Age",
        "key": "age",
        "validations": {
          "required": false,
          "numeric": true,
        },
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
          "Western Cape",
        ],
        "validations": {"required": true},
      },
    ];
  }
}
