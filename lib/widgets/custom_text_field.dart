import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dyn_render/bloc/home_bloc.dart';
import 'package:flutter_dyn_render/models/event.dart';
import 'package:flutter_dyn_render/models/ui_data.dart';

///Textfield where you can't enter but tap
class TappableTextField extends StatefulWidget {
  FieldConfiguration fieldConfiguration;
  HomeBloc _bloc;
  DisplayGroupField field;

  TappableTextField(this.fieldConfiguration, bloc) {
    _bloc = bloc as HomeBloc;
    field = fieldConfiguration.displayGroups[0].fields[0];
  }

  @override
  _TappableTextFieldState createState() => _TappableTextFieldState();
}

class _TappableTextFieldState extends State<TappableTextField> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      TextField(
          controller: _textEditingController,
          enabled: true,
          decoration: InputDecoration(
            labelText: widget.field.label,
            hintText: widget.field.placeholder,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple)),
          )),
      Positioned.fill(
        child: InkWell(
          onTap: () {
            if (widget._bloc is HomeBloc) {
              HomeBloc homeBloc = widget._bloc;
              var rxEvent = RxEvent(RxConstants.SCREEN_NAVIGATION,
                  data: widget.fieldConfiguration);
              homeBloc.navigationEvents.add(rxEvent);
            }
          },
          child: Container(),
        ),
      )
    ]);
  }

  void initListeners() {
    widget._bloc.dataUpdater.listen((RxEvent event) {
      if (event.type == RxConstants.DATA_UPDATE) {
        if (event.data.displayGroups[0].fields[0].formFieldId ==
            widget.fieldConfiguration.displayGroups[0].fields[0].formFieldId) {
          event.widgetData.forEach((val) {
            setState(() {
              _textEditingController.text = val;
            });
          });
        }
      }
    });
  }
}
