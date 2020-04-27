import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  final Function() logoutPressed;

  Logout({key, this.logoutPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        new RaisedButton(
          child: new Text('Logout'),
          onPressed: logoutPressed,
        ),
      ],
    ));
  }
}
