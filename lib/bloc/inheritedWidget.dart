import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  final bloc;

  BlocProvider({Widget child, this.bloc}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static BlocProvider of(BuildContext context) {
    return context.findAncestorRenderObjectOfType();
  }
}
