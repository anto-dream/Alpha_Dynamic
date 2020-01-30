import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_dyn_render/bloc/home_bloc.dart';
import 'package:flutter_dyn_render/models/event.dart';
import 'package:flutter_dyn_render/models/ui_data.dart';

class AutoCompleteTextField<T> extends StatelessWidget {

  List<Option> mockResults = List<Option>();
  FieldConfiguration fieldData;

  DisplayGroupField displayField;
  T bloc;

  AutoCompleteTextField(this.fieldData, this.bloc) {
    displayField = fieldData.displayGroups[0].fields[0];
  }

  @override
  Widget build(BuildContext context) {
    initValues();
    return ChipsInput<Option>(
      decoration: InputDecoration(
          labelText: displayField.label,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple))),
      maxChips: 3,
      findSuggestions: (String query) {
        if (query.length != 0) {
          var lowercaseQuery = query.toLowerCase();
          return mockResults.where((option) {
            return option.display.toLowerCase().contains(query.toLowerCase());
          }).toList(growable: false)
            ..sort((a, b) => a.display
                .toLowerCase()
                .indexOf(lowercaseQuery)
                .compareTo(b.display.toLowerCase().indexOf(lowercaseQuery)));
        } else {
          return const <Option>[];
        }
      },
      onChanged: (data) {
        print(" onChanged $data");
        if (bloc is HomeBloc) {
          HomeBloc homeBloc = bloc as HomeBloc;
          var rxEvent = RxEvent(RxConstants.MULTI_SELECTION, options: data);
          homeBloc.subject.add(rxEvent);
        }
      },
      chipBuilder: (context, state, option) {
        return InputChip(
          key: ObjectKey(option),
          label: Text(option.display),
          onDeleted: (){
            state.deleteChip(option);
            if (bloc is HomeBloc) {
              HomeBloc homeBloc = bloc as HomeBloc;
              var rxEvent = RxEvent(RxConstants.MULTI_SELECTION_DELETION, option: option);
              homeBloc.subject.add(rxEvent);
            }
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      },
      suggestionBuilder: (context, state, profile) {
        return ListTile(
          key: ObjectKey(profile),
          title: Text(profile.display),
          onTap: () => state.selectSuggestion(profile),
        );
      },
    );
  }

  void initValues() {
    displayField.options.forEach((options) {
      mockResults.add(options);
    });
  }
}
