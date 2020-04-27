import '../widgets/main.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login',
        theme: ThemeData(
           primaryColor: Colors.blue,
           accentColor: Colors.blueAccent,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Login'),
            ),
            body: Center(child: Login())));
  }
}
