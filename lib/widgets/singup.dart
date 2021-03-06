import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class SingUp extends StatelessWidget {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _username = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      resizeToAvoidBottomPadding: false,
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
            Center(
                child: new Icon(
              Icons.group_add,
              color: Colors.pink,
              size: 80.0,
              semanticLabel: 'Text to announce in accessibility modes',
            )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 13),
                child: TextFormField(
                  controller: _name,
                  decoration: new InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.account_circle)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo requerido';
                    }

                    return null;
                  },
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 13),
                child: TextFormField(
                  controller: _username,
                  decoration: new InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.assignment_ind)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo requerido';
                    }

                    return null;
                  },
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 13),
                child: TextFormField(
                  controller: _email,
                  decoration: new InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo requerido';
                    }

                    return null;
                  },
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 13),
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: new InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo requerido';
                    }

                    return null;
                  },
                )),
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textColor: Colors.white,
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    print("despues debe pasar algo");
                    getcontext(context);
                    signUp(
                        email: _email.text,
                        password: _password.text,
                        username: _username.text,
                        name: _name.text);
                    int status = getRegisterStatus();
                    if (status == 200) {
                      _onPress(context);
                    }
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
