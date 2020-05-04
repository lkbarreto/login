import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/login.dart';

String _email="";
String _name="";
String _token="";
BuildContext context2;

Future<UserInfo> signUp(
    {String email, String password, String username, String name}) async {
  final http.Response response = await http.post(
    'https://movil-api.herokuapp.com/signup',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'username': username,
      'name': name
    }),
  );

  print('${response.body}' + "algo pasa aqui");
  print('${response.statusCode}');
  final body = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print('${response.body}');
    print('Email: ${body['email']}');
    print('Token: ${body['token']}');
    return UserInfo.fromJson(json.decode(response.body));
  } else {
    print("signup failed");
    print('${response.body}');
    alert('${body['error']}');
    
    throw Exception(response.body);
  }
}

Future<UserInfo> signIn({String email, String password}) async {
  final http.Response response = await http.post(
    'https://movil-api.herokuapp.com/signin',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'password': password}),
  );

  print('${response.body}' + "Sign IN mio");
  print('${response.statusCode}');
  final body = jsonDecode(response.body);

  if (response.statusCode == 200) {
    print('${response.body}');
    print('Email: ${body['email']}');
    print('Token: ${body['token']}');
    _email='${body['email']}';
    _name='${body['name']}';
    _token='${body['token']}';

    return UserInfo.fromJson(json.decode(response.body));
  } else {
    print("signup failed");
    print('${response.body}');
    alert('${body['error']}');
    
    print('Error: ${body['error']}');
    throw Exception(response.body);
  }
}

void getcontext(BuildContext context){
    context2 =context;
}

alert(String alerta){
          showDialog(
          context: context2,
          builder: (context) {
            return AlertDialog(
              title: Text('Alerta'),
              content: Text(alerta),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK')),
              ],
            );
          });
}

String getEmail(){
return _email;
}
String getName(){
return _name;
}
String getToken(){
return _token;
}
class UserInfo {
  final String token;
  final String username;
  final String name;

  UserInfo({this.token, this.username, this.name});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }

  
}
