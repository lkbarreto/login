import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/logout.dart';
import '../widgets/login.dart';
import '../model/user.dart';

enum WidgetMarker { Login, Logout, UserInfo }


class Model extends ChangeNotifier {
  WidgetMarker _state = WidgetMarker.Login;

  String _text = "Ingrese";
  bool _logged = false;
  String _email = "";
  String _password = "";

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

  _getLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _logged = (prefs.getBool('loggedIn') ?? false);
  }

  _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email') ?? "...");
  }

  _getPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _password = (prefs.getString('password') ?? "...");
  }

  WidgetMarker get state => _state;

  String get text => _text;

  void view() {
    if (_logged) {
      _text = "Bienvenido";
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
        return Login(
          loginPressed: (pass, email) {
            _getEmail();
            _getPass();
            if (pass == _password && email == _email) {
              _setLogin();
              view();
            }
          },
        );
      case WidgetMarker.Logout:
        return Logout(logoutPressed: () {
          _setLogout();
          view();
        });
      default:
        return Login(
          loginPressed: (pass, email) {
            _getEmail();
            _getPass();
          },
        );
    }
  }

  void changeValue(WidgetMarker value) {
    _state = value;
    notifyListeners();
  }
}
