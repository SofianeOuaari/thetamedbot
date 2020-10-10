import 'package:flutter/foundation.dart';

class SplashService with ChangeNotifier {
  SplashService();

  bool _isFirst = false;
  bool get isFirst => _isFirst ?? false;

  changeIsFirst(bool type) {
    _isFirst = type;
    notifyListeners();
  }
}
