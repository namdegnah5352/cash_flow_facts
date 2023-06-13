import 'package:flutter/material.dart';

class AppNavigation {

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  static final AppNavigation _singleton = AppNavigation._internal();

  factory AppNavigation(){
    return _singleton;
  }
  AppNavigation._internal();

  Future<T?> pushNamed<T, S>(String routeName, {S? arguments}) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pushNamed(
        routeName,
        arguments: arguments,
      );
    }
    return throw (Exception());
  }
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  void pop<T>({T? arguments}) {
    return navigatorKey.currentState!.pop(arguments);
  }  
}