import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.auth, required this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}
enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String? userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          //UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              //email: _email, password: _password);
          print('signed in: $userId');
        } else {
          String? userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          //UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            //  email: _email, password: _password);
          print('registered user: $userId');
        }
        widget.onSignedIn();
      }
      catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState?.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState?.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Music Stream'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
              child: Column(
                children: buildInputs() + buildSubmitButtons(),
              )),
        ),
      );
  }
  List<Widget> buildInputs() {

    return [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Email'),
        validator: (value) => value!.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value!,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) => value!.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value!,

      ),
    ];
  }
  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        ElevatedButton(
            onPressed: validateAndSubmit,
            child: const Text('Login', style: TextStyle(fontSize: 20.0, ),)
        ),
        TextButton(
          onPressed: moveToRegister,
          child: const Text('Create an account', style: TextStyle(fontSize: 20.0)),
        )
      ];
    } else {
      return [
        ElevatedButton(
            onPressed: validateAndSubmit,
            child: const Text('Register', style: TextStyle(fontSize: 20.0),)
        ),
        TextButton(
          onPressed: moveToLogin,
          child: const Text('Have an account? Login', style: TextStyle(fontSize: 20.0)),
        )
      ];
    }

  }
}