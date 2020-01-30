import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dyn_render/bloc/blocBase.dart';
import 'package:flutter_dyn_render/constants.dart';
import 'package:flutter_dyn_render/widgets/custom.dart';
import 'package:flutter_dyn_render/widgets/expandable_controller.dart';

import 'models/ui_data.dart';

class WidgetGenerator<T> {
  static Map<int, String> quantities = {};

  static Widget generateWidget(BlocBase bloc, FieldConfiguration data) {
    Widget widget;
    switch (data.displayGroups[0].fields[0].controlType) {
      case TypeConstants.TEXT_BOX:
        widget = generateTextBox(data, bloc);
        break;
      case TypeConstants.MULTI_SELECT:
        widget = AutoCompleteTextField(data, bloc);
        break;
      case TypeConstants.SINGLE_SELECT:
        widget = generateTextBox(data, bloc);
        break;
      case TypeConstants.CURRENCY:
        widget = Container();
        break;
      case TypeConstants.SECURITY_SEARCH:
        widget = Container();
        break;
      case TypeConstants.BROKER_ACCOUNT_SEARCH:
        widget = Container();
        break;
      case TypeConstants.RADIO_BUTTON:
        widget = Container();
        break;
      case TypeConstants.TOGGLE_BUTTON:
        widget = Container();
        break;
      case TypeConstants.DATE_PICKER:
        widget = Container();
        break;
      case TypeConstants.TEXT_AREA:
        widget = Container();
        break;
      case TypeConstants.INSTRUCTIONAL:
        widget = Container();
        break;
      case TypeConstants.CHECKBOX:
        widget = Container();
        break;
      case TypeConstants.FILE_UPLOAD:
        widget = Container();
        break;
      default:
        widget = Container();
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget,
    );
  }

  static Widget generateTextBox(FieldConfiguration dataItem, BlocBase bloc) {
    var field = dataItem.displayGroups[0].fields[0];
    var textField = TextField(
        enabled: true,
        decoration: InputDecoration(
          labelText: field.label,
          hintText: field.placeholder,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
        ));
    print("dataOrder ${dataItem.order}");
    if (dataItem.order % 1 == 0) {
      return textField;
    } else {
      return ExpandableControllerWidget(textField, dataItem, bloc: bloc);
    }
  }

  static Widget generateTextField(FieldConfiguration dataItem) {
    return TextField(
        enabled: true,
        decoration: InputDecoration(
          labelText: 'tet',
          hintText: "An Outline Border TextField",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
        ));
  }

  static void updateFormData(FieldConfiguration dataItem, String value) {
    /*quantities.update(dataItem.id, (val) {
      print('val $val');
      return value;
    }, ifAbsent: () {
      print("absent");
      return value;
    });*/
  }

  static Widget generateFlatButton(FieldConfiguration data) {
    return FlatButton();
  }

  static void generateRow(FieldConfiguration data) {}

  static void printData() {
    print(quantities);
  }
}

class CustomCheckBoxTile extends StatefulWidget {
  final FieldConfiguration dataItem;

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
  final FieldConfiguration data;

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
  DropDown();

  @override
  DropDownWidget createState() => DropDownWidget();
}

class DropDownWidget extends State {
  var _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  String dropdownValue = 'One';
  var _currentSelectedValue;
  List<String> spinnerItems = ['One', 'Two', 'Three', 'Four', 'Five'];

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: 'Please select expense',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: _currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _currentSelectedValue,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  _currentSelectedValue = newValue;
                  state.didChange(newValue);
                });
              },
              items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
