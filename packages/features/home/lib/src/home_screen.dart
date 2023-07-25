import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_repository/form_repository.dart';

class HomeScreen extends StatefulWidget {
  final FormRepository formRepository;

  const HomeScreen({
    super.key,
    required this.formRepository,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Forms"),
      ),
      body: FutureBuilder<DynamicForm?>(
        future: widget.formRepository.loadForm(),
        builder: (BuildContext context, AsyncSnapshot<DynamicForm?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Loading form, please wait..."),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Something bad happened ${snapshot.error}"),
            );
          }
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: snapshot.data!.fields
                      .map(
                        (field) => DynamicFormInput(
                          field: field,
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          }
          return const Center(child: Text("Form does not exist."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 10),
                content: Text(
                  'Form successfully validated and saved. Form data: ${_formKey.currentState!.value}',
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text('Form validation failed'),
              ),
            );
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class DynamicFormInput extends StatelessWidget {
  final DynamicFormField field;

  const DynamicFormInput({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    switch (field.type) {
      case 'TextBox':
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: FormBuilderTextField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: field.key,
            decoration: InputDecoration(labelText: field.label),
            keyboardType: _getInputType(
              field.validations.numeric,
              field.validations.email,
            ),
            validator: FormBuilderValidators.compose(
              [
                if (field.validations.required)
                  FormBuilderValidators.required(errorText: 'Required'),
                if (field.validations.email != null && field.validations.email == true)
                  FormBuilderValidators.email(errorText: "A valid email is required"),
                if (field.validations.numeric != null && field.validations.numeric == true)
                  FormBuilderValidators.numeric(errorText: "A number is required"),
                if (field.validations.minLength != null)
                  FormBuilderValidators.minLength(field.validations.minLength!),
                if (field.validations.maxLength != null)
                  FormBuilderValidators.maxLength(field.validations.maxLength!),
              ],
            ),
          ),
        );

      case 'DropdownList':
        return FormBuilderDropdown(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          name: field.key,
          decoration: InputDecoration(labelText: field.label),
          items: field.options!
              .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          validator: FormBuilderValidators.compose([
            if (field.validations.required)
              FormBuilderValidators.required(errorText: 'Please make a selection'),
          ]),
        );

      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Field Type [${field.type}] does not exist.",
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }

  TextInputType _getInputType(bool? numeric, bool? email) {
    if (numeric != null && numeric == true) {
      return TextInputType.number;
    }
    if (email != null && email == true) {
      return TextInputType.emailAddress;
    }
    return TextInputType.text;
  }
}
