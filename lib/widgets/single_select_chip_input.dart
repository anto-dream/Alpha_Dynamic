import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_dyn_render/bloc/blocBase.dart';
import 'package:flutter_dyn_render/bloc/home_bloc.dart';
import 'package:flutter_dyn_render/models/event.dart';
import 'package:flutter_dyn_render/models/ui_data.dart';

class SingleSelectChipInputField extends StatelessWidget {
  final FieldConfiguration _fieldConfiguration;
  final BlocBase _bloc;
  DisplayGroupField displayField;

  SingleSelectChipInputField(this._fieldConfiguration, this._bloc) {
    displayField = _fieldConfiguration.displayGroups[0].fields[0];
  }

  @override
  Widget build(BuildContext context) {
    var initialVal = List<String>();
    initialVal.add("Sample 123");
    return Stack(children: <Widget>[
      ChipsInput<String>(
        findSuggestions: _findSuggestions,
          onChanged: _onChanged,
          initialValue: initialVal,
          suggestionBuilder: findSuggestions,
          decoration: InputDecoration(
              labelText: displayField.label,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple))),
          maxChips: 9,
          chipBuilder: (context, state, option) {
            return InputChip(
              deleteIcon: null,
              key: ObjectKey(option),
              label: Text(option),
              onDeleted: () {
                state.deleteChip(option);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }),
      Positioned.fill(
        child: InkWell(
          onTap: () {
            if (_bloc is HomeBloc) {
              HomeBloc homeBloc = _bloc as HomeBloc;
              var rxEvent = RxEvent(RxConstants.SCREEN_NAVIGATION, data: _fieldConfiguration);
              homeBloc.navigationEvents.add(rxEvent);
            }
          },
          child: Container(),
        ),
      )
    ]);
  }

  FutureOr<List> _findSuggestions(String query) {
  }

  void _onChanged(List<String> value) {
  }

  Widget findSuggestions(BuildContext context, ChipsInputState<String> state, String data) {
  }
}
