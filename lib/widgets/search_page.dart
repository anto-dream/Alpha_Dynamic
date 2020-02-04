import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchEdit = new TextEditingController();
  PublishSubject<String> _publishSubject = PublishSubject();

  @override
  void dispose() {
    _publishSubject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SearchTextField(_searchEdit, _publishSubject),
            Divider(),
            getSecurityTag(),
            UpdatableList(_publishSubject)
          ],
        ),
      ),
    );
  }

  Padding getSecurityTag() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Text("SECURITY"),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController _controller;
  final PublishSubject<String> _behaviorSubject;

  SearchTextField(this._controller, this._behaviorSubject);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      child: Row(children: <Widget>[
        Expanded(flex: 1, child: Icon(Icons.arrow_back_ios)),
        Expanded(
          flex: 9,
          child: TextField(
            controller: _controller,
            onChanged: (data) {
              _behaviorSubject.add(data);
            },
            decoration: InputDecoration.collapsed(hintText: "search"),
          ),
        )
      ]),
    );
  }
}

class UpdatableList extends StatelessWidget {
  final PublishSubject<String> _publishSubject;
  List<String> _socialListItems;
  final List<String> _searchListItems = new List<String>();

  UpdatableList(this._publishSubject) {
    _socialListItems = new List<String>();
    _socialListItems = [
      "Facebook",
      "Instagram",
      "Twitter",
      "LinkedIn",
      "Messenger",
      "WhatsApp",
      "Naukri",
      "Medium",
      "Tinder",
      "Gmail",
      "Hangouts",
      "Google Plus",
      "Snapchat",
      "True Caller",
      "WeChat",
      "Pinterest",
      "Quora"
    ];
    _socialListItems.sort();
  }

  void updateSearchList(String value) {
    print("updating list");
    _searchListItems.clear();
    _socialListItems.forEach((item) {
      if (item.toLowerCase().contains(value.toLowerCase())) {
        _searchListItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: _publishSubject.debounceTime(Duration(milliseconds: 500)),
        initialData: "",
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.data != null) {
            updateSearchList(snapshot.data);
            return Flexible(
              child: new ListView.separated(
                itemCount: snapshot.data.isEmpty
                    ? _socialListItems.length
                    : _searchListItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data.isEmpty
                        ? _socialListItems[index]
                        : _searchListItems[index]),
                    subtitle: Text(snapshot.data.isEmpty
                        ? _socialListItems[index]
                        : _searchListItems[index]),
                    trailing: Icon(Icons.subject),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
    ;
  }
}
