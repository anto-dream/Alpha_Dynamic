import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dyn_render/constants.dart';

import 'models/ui_data.dart';

class WidgetGenerator {
  static Map<int, String> quantities = {};

  /*static Widget generateWidget(UiData data) {
    Widget widget;
    switch (data.payload.data[0].fieldConfiguration[0].displayGroups[0].type) {
      case TypeConstants.TEXT_VIEW:
        widget = generateTextView(data);
        break;
      case TypeConstants.TEXT_FIELD:
        widget = generateTextField(data);
        break;
      case TypeConstants.TEXT_FIELD:
        widget = generateTextField(data);
        break;
      case TypeConstants.FLAT_BUTTON:
        widget = generateFlatButton(data);
        break;
      case TypeConstants.ROW:
        generateRow(data);
        break;
      case TypeConstants.CHECK_BOX:
        widget = CustomCheckBoxTile(data);
        break;
      case TypeConstants.RADIO_BUTTON:
        widget = CustomRadiobutton(data);
        break;
      case TypeConstants.DROP_DOWN:
        widget = DropDown(data);
        break;
      default:
        widget = CircularProgressIndicator();
        break;
    }
    return widget;
  }

  static Widget generateTextView(UiData dataItem) {
    return Text(
      dataItem.displayGroups[0].fields[0].label,
      style: TextStyle(fontSize: 20),
    );
  }

  static Widget generateTextField(UiModel dataItem) {
    return TextField(
        onChanged: (value) {
          updateFormData(dataItem, value);
        },
       *//* decoration: new InputDecoration(
            labelText: dataItem.title, hintText: dataItem.data.displayName)*//*);
  }

  static void updateFormData(UiModel dataItem, String value) {
    *//*quantities.update(dataItem.id, (val) {
      print('val $val');
      return value;
    }, ifAbsent: () {
      print("absent");
      return value;
    });*//*
  }

  static Widget generateFlatButton(UiModel data) {
    return FlatButton();
  }

  static void generateRow(UiModel data) {}

  static void printData() {
    print(quantities);
  }
}

class CustomCheckBoxTile extends StatefulWidget {
  final UiModel dataItem;

  CustomCheckBoxTile(this.dataItem);

  @override
  _CustomCheckBoxTileState createState() => _CustomCheckBoxTileState();
}

class _CustomCheckBoxTileState extends State<CustomCheckBoxTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: true,
      title: Text('test'),
      onChanged: (bool value) {
        setState(() {
          WidgetGenerator.updateFormData(widget.dataItem, value.toString());

        });
      },
    );
  }
}

class CustomRadiobutton extends StatefulWidget {
  final UiModel data;

  CustomRadiobutton(this.data);

  @override
  _CustomRadiobuttonState createState() => _CustomRadiobuttonState();
}

class _CustomRadiobuttonState extends State<CustomRadiobutton> {
  String _radioValue1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            new Radio<String>(
              value: "uu",
              groupValue: _radioValue1,
              onChanged: _handleRadioValueChange1,
            ),
            new Text(
              "uu",
              style: new TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            new Radio<String>(
              value: 'huf',
              groupValue: _radioValue1,
              onChanged: _handleRadioValueChange1,
            ),
            new Text(
              'ji',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleRadioValueChange1(String value) {
    setState(() {
      _radioValue1 = value;
      WidgetGenerator.updateFormData(widget.data, value);
    });
  }
}

class DropDown extends StatefulWidget {
  UiModel dataItem;

  DropDown(this.dataItem);

  @override
  DropDownWidget createState() => DropDownWidget();
}

class DropDownWidget extends State {
  String dropdownValue = 'One';

  List<String> spinnerItems = ['One', 'Two', 'Three', 'Four', 'Five'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.red, fontSize: 18),
      onChanged: (String data) {
        setState(() {
          dropdownValue = data;
        });
      },
      items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }*/
}
