import 'package:flutter/foundation.dart';

class LoaderService with ChangeNotifier {
  bool _isLoad = false;
  bool get isLoad => _isLoad ?? false;

  changeIsLoad(bool type) {
    _isLoad = type;
    notifyListeners();
  }
}
