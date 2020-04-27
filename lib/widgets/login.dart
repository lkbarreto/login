import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final Function() loginPressed;

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  Login({key, this.loginPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _email,
              decoration: new InputDecoration(labelText: 'Email'),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _password,
              decoration: new InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          ),
          new Container(
            child: new Column(
              children: <Widget>[
                new RaisedButton(
                  child: new Text('Login'),
                  onPressed: () => _onPress(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onPress(BuildContext context) {
    if (_password.text.isEmpty || _email.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Alerta'),
              content: Text('Campos incompletos!'),
              actions: <Widget>[
              
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK')),
              ],
            );
          });
    } else {
      loginPressed();
    }
  }
}
