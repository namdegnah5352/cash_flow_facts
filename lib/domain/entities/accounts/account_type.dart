import 'package:flutter/material.dart';

class AccountType {
  int _id = 0;
  String _iconPath = "";
  String _typeName = "";
  late Future<Widget> _loadThis;

  AccountType({id, iconPath, typeName, loadThis}) {
    _id = id;
    _iconPath = iconPath;
    _typeName = typeName;
    _loadThis = loadThis;
  }

  int get id => _id;
  String get iconPath => _iconPath;
  String get typeName => _typeName;
  Future<Widget> get loadThis => _loadThis;
  set id(int id) => _id = id;
  set iconPath(String iconPath) => _iconPath = iconPath;
  set typeName(String typeName) => _typeName = typeName;
  set loadThis(Future<Widget> loadThis) => _loadThis = loadThis;
}
