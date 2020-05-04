import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/logout.dart';
import '../widgets/login.dart';
import '../model/user.dart';

enum WidgetMarker { Login, Logout, Usernfo }

class Model extends ChangeNotifier {
  WidgetMarker _state = WidgetMarker.Login;

  String _text = "Ingrese";
  bool _logged = false;
  String _email = "";
  String _token = "";
  String _name = "";

  _setLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);
    view();
  }

  _setLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', true);
    view();
  }

  _setToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token);
    view();
  }

  _setName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _name);
    view();
  }

  _getLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _logged = (prefs.getBool('loggedIn') ?? false);
  }

  WidgetMarker get state => _state;

  String get text => _text;

  void view() {
    if (_logged) {
      _text = "Bienvenido " + _name;
      changeValue(WidgetMarker.Logout);
    } else {
      _text = "Ingrese";
      changeValue(WidgetMarker.Login);
    }
  }

  Widget getCurrent() {
    _getLogged();
    switch (_state) {
      case WidgetMarker.Login:
        _token = getToken();
        _email = getEmail();
        _name = getName();

        return Login(
          loginPressed: () {
            _token = getToken();
            _email = getEmail();
            _name = getName();
            print(_token);
            print(_email);
            print(_name);
            if (_token != "") {
              _setLogin();
              _setName();
              _setToken();
              view();
            }
          },
        );
      case WidgetMarker.Logout:
        return Logout(logoutPressed: () {
          _setLogout();
          _token = "";
          view();
        });
      default:
        return Login(
          loginPressed: () {},
        );
    }
  }

  void changeValue(WidgetMarker value) {
    _state = value;
    notifyListeners();
  }
}
