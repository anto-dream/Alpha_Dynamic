import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dyn_render/bloc/blocBase.dart';
import 'package:flutter_dyn_render/bloc/home_bloc.dart';
import 'package:flutter_dyn_render/constants.dart';
import 'package:flutter_dyn_render/models/event.dart';
import 'package:flutter_dyn_render/widgets/custom_chip_input_field.dart';
import 'package:flutter_dyn_render/widgets/custom_text_field.dart';
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
        widget = MultiSelectChipField(data, bloc);
        break;
      case TypeConstants.SINGLE_SELECT:
        widget = TappableTextField(data, bloc);
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
    final double padding = (data.order % 1 == 0) ? 8.0 : 0.0;
    final bool expand = data.order % 1 == 0;
    return Padding(
        padding: EdgeInsets.all(padding),
        child: !expand
            ? ExpandableControllerWidget(widget, data, bloc: bloc)
            : widget);
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
    return textField;
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

  static void printData() {
    print(quantities);
  }
}

class MultiSelectChipField extends StatefulWidget {
  FieldConfiguration fieldConfiguration;
  HomeBloc homeBloc;

  MultiSelectChipField(this.fieldConfiguration, BlocBase bloc) {
    homeBloc = bloc as HomeBloc;
  }

  @override
  _MultiSelectChipFieldState createState() => _MultiSelectChipFieldState();
}

class _MultiSelectChipFieldState extends State<MultiSelectChipField> {
  Set<Option> inputChips = Set();
  @override
  void initState() {
    super.initState();
    initListeners();
  }

  @override
  Widget build(BuildContext context) {
    var field = widget.fieldConfiguration.displayGroups[0].fields[0];
    print('build ${inputChips.length}');
    return CustomChipInput<Option>(
      chips: inputChips,
        onTapped: () {
          if (widget.homeBloc is HomeBloc) {
            HomeBloc homeBloc = widget.homeBloc as HomeBloc;
            homeBloc.navigationEvents.add(
                RxEvent(RxConstants.SCREEN_NAVIGATION, data: widget.fieldConfiguration));
          }
        },
        label: field.label,
        chipsBuilder: (context, state, option) {
          return InputChip(
            key: ObjectKey(option),
            label: Text(option.display),
            onDeleted: () => state.deleteChip(option),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );
        });
  }

  void initListeners() {
    widget.homeBloc.dataUpdater.listen((RxEvent event) {
      if (event.type == RxConstants.DATA_UPDATE) {
        if (event.data.displayGroups[0].fields[0].formFieldId ==
            widget.fieldConfiguration.displayGroups[0].fields[0].formFieldId) {
          event.widgetData.forEach((val) {
            setState(() {
              inputChips.add(val);
            });
          });
        }
      }
    });
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
