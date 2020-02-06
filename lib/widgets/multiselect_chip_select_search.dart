import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_dyn_render/models/navigation.dart';
import 'package:flutter_dyn_render/models/ui_data.dart';

class MultiSelectChipSearchPage extends StatelessWidget {
  FieldConfiguration fieldConf;
  List<Option> mockResults = List();
  List<Option> result = List();
  var field;

  MultiSelectChipSearchPage(this.fieldConf) {
    field = fieldConf.displayGroups[0].fields[0];
    initValues();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Card(
                elevation: 8.0,
                margin: EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildChipsInput(),
                )),
            MaterialButton(
              onPressed: () {
                print(result.toString());
                popPage(context);
              },
              height: 50.0,
              color: Colors.blue,
              child: Text('Done'),
            )
          ],
        ),
      ),
    );
  }

  ChipsInput<Option> buildChipsInput() {
    return ChipsInput<Option>(
      decoration: InputDecoration.collapsed(),
      maxChips: 9,
      findSuggestions: (String query) {
        return _findSuggestions(query);
      },
      onChanged: (data) {
        print(" onChanged $data");
        result.clear();
        result.addAll(data);
        sendSelectionEvent(data);
      },
      chipBuilder: (context, state, option) {
        return InputChip(
          key: ObjectKey(option),
          label: Text(option.display),
          onDeleted: () {
            state.deleteChip(option);
            sendDeletionEvent(option);
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

  void sendDeletionEvent(Option option) {
    /* if (bloc is HomeBloc) {
      HomeBloc homeBloc = bloc as HomeBloc;
      var rxEvent =
      RxEvent(RxConstants.MULTI_SELECTION_DELETION, option: option);
      homeBloc.subject.add(rxEvent);
    }*/
  }

  void sendSelectionEvent(List<Option> data) {
    /*if (bloc is HomeBloc) {
      HomeBloc homeBloc = bloc as HomeBloc;
      var rxEvent = RxEvent(RxConstants.MULTI_SELECTION, options: data);
      homeBloc.subject.add(rxEvent);
    }*/
  }

  List<Option> _findSuggestions(String query) {
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
  }

  void initValues() {
    field.options.forEach((options) {
      mockResults.add(options);
    });
  }

  void popPage(BuildContext context) {
    Navigator.pop(context, RouteData(fieldConf, result));
  }
}
