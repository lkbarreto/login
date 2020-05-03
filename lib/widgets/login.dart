import 'package:flutter/material.dart';
import './singup.dart';
import '../model/user.dart';
import '../model/model.dart';
import 'package:provider/provider.dart';

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
                  onPressed: () => _onPress(context)
                                    /*signIn(email: _email.toString(), password: _password.toString())
                                    .then((user) {
                                    Provider.of<Model>(context, listen: false)
                                    .setLoggedIn(user.username);
                                            return _buildDialog(context, "Exito!", "Done");
                                    }).catchError((error) {
                                            return _buildDialog(context, "Error", error.toString());
                                    }).timeout(Duration(seconds: 10), onTimeout: () {
                                            return _buildDialog(context, "Error", "Timeout > 10secs");
                                    })*/
                                    ,
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
      loginPressed(_password.text, _email.text);
    }
  }
}
