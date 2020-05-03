import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class SingUp extends StatelessWidget {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email,name,username,password;

  _addEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email.text);
  }

  _addPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password', _password.text);
  }

  _addlogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro"),
      ),
      body: Center(
          child: Container(
              child: new Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
             // controller: _email,
              decoration: new InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Campo requerido';
                }
                name=value;
                return null;
              },
            ),
            TextFormField(
              //controller: _email,
              decoration: new InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Campo requerido';
                }
                username=value;
                return null;
              },
            ),
            TextFormField(
              controller: _email,
              decoration: new InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Campo requerido';
                }
                email=value;
                return null;
              },
            ),
            TextFormField(
              controller: _password,
              decoration: new InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Campo requerido';
                }
                password=value;
                return null;
              },
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    print("despues debe pasar algo");
                    signUp(email:email, password: password,username: username, name: name);
                    _onPress(context);
                  }
                },
                child: Text('Registrarme'),
              ),
            )),
          ],
        ),
      ))),
    );
  }

  void _onPress(BuildContext context) {
    _addEmail();
    _addPass();
    _addlogin();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hecho'),
            content: Text('Usuario registrado!'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK')),
            ],
          );
        });
  }
}
