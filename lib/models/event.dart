import 'package:flutter_dyn_render/models/ui_data.dart';

class RxEvent {
  FieldConfiguration data;
  List<Option> options;
  Option option;
  int type;

  RxEvent(this.type, {this.data, this.options, this.option});

  @override
  String toString() {
    return 'RxEvent{type: $type}';
  }


}

class RxConstants {
  static const int MULTI_SELECTION = 1;
  static const int MULTI_SELECTION_DELETION =2;
}
