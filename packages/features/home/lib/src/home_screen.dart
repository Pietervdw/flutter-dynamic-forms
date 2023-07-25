import 'package:extensions_library/extensions_library.dart';
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
        title: const Text('Contact Details Form'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: widget.formRepository.loadForm(id: 1),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
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
                  children: snapshot.data!
                      .map(
                        (field) => DynamicFormField(
                          fieldData: field,
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

class DynamicFormField extends StatelessWidget {
  final Map<String, dynamic> fieldData;

  const DynamicFormField({
    super.key,
    required this.fieldData,
  });

  @override
  Widget build(BuildContext context) {
    final validations = fieldData['validations'];
    final fieldType = fieldData['type'];
    final fieldLabel = fieldData['label'];

    switch (fieldType) {
      case 'TextBox':
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: FormBuilderTextField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: fieldData['key'].toString(),
            decoration: InputDecoration(labelText: fieldLabel),
            keyboardType: (validations != null && validations['numeric'] != null)
                ? const TextInputType.numberWithOptions()
                : null,
            validator: FormBuilderValidators.compose(
              [
                if (validations != null && validations['required'])
                  FormBuilderValidators.required(errorText: 'Required'),
                if (validations != null && validations['minLength'] != null)
                  FormBuilderValidators.minLength(validations['minLength']),
                if (validations != null && validations['maxLength'] != null)
                  FormBuilderValidators.maxLength(validations['maxLength']),
                if (validations != null && validations['email'] != null)
                  FormBuilderValidators.email(errorText: "A valid email is required"),
                if (validations != null && validations['numeric'] != null)
                  FormBuilderValidators.numeric(errorText: "A number is required"),
              ],
            ),
          ),
        );
      case 'DropdownList':
        return FormBuilderDropdown(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          name: fieldData['key'].toString(),
          decoration: InputDecoration(labelText: fieldLabel.toString()),
          items: fieldData['options']
              .map<DropdownMenuItem<String>>(
                (String province) => DropdownMenuItem(
                  value: province,
                  child: Text(province),
                ),
              )
              .toList(),
          validator: FormBuilderValidators.compose([
            if (validations != null && validations['required'])
              FormBuilderValidators.required(errorText: 'Please make a selection'),
          ]),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Field Type [${fieldType.toString()}] does not exist.",
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }
}
