import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Model>(
        create: (context) => Model(),
        child: Consumer<Model>(
          builder: (context, model, child) {
            return Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${model.text}",
                          style:
                              TextStyle(color: Theme.of(context).accentColor)),
                    ),
                    Expanded(
                        flex: 10,
                        child: SizedBox(
                          height: double.infinity,
                          child: model.getCurrent(),
                        )),
                  ]),
            );
          },
        ));
  }
}
