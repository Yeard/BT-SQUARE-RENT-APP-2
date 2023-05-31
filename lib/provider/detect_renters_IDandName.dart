import 'package:flutter/cupertino.dart';

class DetectRentersIdandName extends ChangeNotifier {
  int _id = 0;
  String _name = '';
  String _type = '';

  int get id => _id;
  String get name => _name;
  String get type => _type;

  set id(int value) {
    _id = value;
    notifyListeners();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set type(String value) {
    _type = value;
    notifyListeners();
  }
}
