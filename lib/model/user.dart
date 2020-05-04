import 'dart:convert';
import 'package:http/http.dart' as http;

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
  if (response.statusCode == 200) {
    print('${response.body}');
    return UserInfo.fromJson(json.decode(response.body));
  } else {
    print("signup failed");
    print('${response.body}');
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
  if (response.statusCode == 200) {
    print('${response.body}');
    return UserInfo.fromJson(json.decode(response.body));
  } else {
    print("signup failed");
    print('${response.body}');
    throw Exception(response.body);
  }
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
