import 'package:flutter/material.dart';
import './singup.dart';
import '../model/user.dart';

class Login extends StatelessWidget {
  final Function(String pass, String email) loginPressed;

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  Login({key, this.loginPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Icon(
              Icons.account_circle,
              color: Colors.pink,
              size: 80.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
          new Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 13),
            child: new TextField(
              controller: _email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email)),
            ),
          ),
          new Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 13),
            child: new TextField(
              controller: _password,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
          ),
          new Container(
            child: new Column(
              children: <Widget>[
                new RaisedButton(
                  child: new Text('Login'),
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textColor: Colors.white,
                  onPressed: () => _onPress(context),
                ),
              ],
            ),
          ),
          new Container(
            child: new Column(
              children: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SingUp()),
                    );
                  },
                  child: Text(
                    "No tienes cuenta? Registrate",
                  ),
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
      signIn(
        email: _email.text,
        password: _password.text,
      );
      loginPressed(_password.text, _email.text);
    }
  }
}
