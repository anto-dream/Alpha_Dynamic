import 'package:flutter_dyn_render/models/ui_data.dart';

class RxEvent {
  int type;
  FieldConfiguration data;
  List<Option> options;
  Option option;
  //widget data in case of update
  List<String> widgetData;

  RxEvent(this.type, {this.data, this.options, this.option, this.widgetData});

  @override
  String toString() {
    return 'RxEvent{type: $type}';
  }
}

class RxConstants {
  static const int MULTI_SELECTION = 1;
  static const int MULTI_SELECTION_DELETION =2;
  static const int SCREEN_NAVIGATION = 3;
  static const int DATA_UPDATE = 4;
}

