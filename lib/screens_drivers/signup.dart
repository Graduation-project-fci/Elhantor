import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CountryCodePicker(
                onChanged: (element) => debugPrint(element.toLongString()),
                initialSelection: 'TF',
                showCountryOnly: true,
                showOnlyCountryWhenClosed: true,
                favorite: const ['+20', 'EG'],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10)
                ],
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Phone number is required';
                  } else if (value.length < 10) {
                    return 'Phone number must be at least 10 digits';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _phoneNumber = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Sign Up'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO: Implement sign-up logic using phone number
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}