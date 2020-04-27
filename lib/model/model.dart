import 'package:flutter/material.dart';
import '../widgets/logout.dart';
import '../widgets/login.dart';

enum WidgetMarker { Login, Logout }

class Model extends ChangeNotifier {
  WidgetMarker _state = WidgetMarker.Login;

  String _text = "Ingrese";

  WidgetMarker get state => _state;

  String get text => _text;

  void view() {
    switch (_state) {
      case WidgetMarker.Login:
        _text = "Bienvenido";
        changeValue(WidgetMarker.Logout);
        break;
      case WidgetMarker.Logout:
        _text = "Ingrese";
        changeValue(WidgetMarker.Login);
        break;
    }
  }

  Widget getCurrent() {
    switch (_state) {
      case WidgetMarker.Login:
        return Login(
          loginPressed: () {
            view();
          },
        );
      case WidgetMarker.Logout:
        return Logout(logoutPressed: () {
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
