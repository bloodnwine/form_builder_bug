import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // call a fake async function
    Future.delayed(Duration(seconds: 3)).then((_) {
      _formKey.currentState.setState(() {
        _nameController.text = '13 characters';
      });
      _formKey.currentState.save();
    });
  }

  Widget _buildTextField() {
    return FormBuilderTextField(
      name: 'name',
      controller: _nameController,
      decoration: InputDecoration(labelText: 'Name', filled: true),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(context, 4),
        FormBuilderValidators.maxLength(context, 16),
      ]),
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      child: Text('Submit'),
      onPressed: () {
        _formKey.currentState.save();
        if (_formKey.currentState.validate()) {
          print(_formKey.currentState.value);
        } else {
          print("validation failed");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_buildTextField(), _buildSubmitButton()],
            ),
          ),
        ),
      ),
    );
  }
}
