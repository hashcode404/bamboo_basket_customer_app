import 'package:flutter/material.dart';

class GlobalVariable {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  static BuildContext? get context => globalKey.currentState?.context;
}
