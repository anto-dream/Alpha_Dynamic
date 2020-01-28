import 'package:flutter/material.dart';
import 'package:flutter_dyn_render/assets/uidata.dart';
import 'package:flutter_dyn_render/floop_sample.dart';
import 'package:flutter_dyn_render/models/data.dart';
import 'package:flutter_dyn_render/models/ui_data.dart';
import 'package:flutter_dyn_render/widgetGenerator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  int i;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage1(),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  @override
  _MyHomePageState1 createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<MyHomePage1> {
  List<Item> itemList = [
    Item("ID1", "First product"),
    Item("ID2", "Second product"),
  ];

  Map<String, int> quantities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo")),
      body: FutureBuilder<String>(
          future: UiResponse().loadAsset(),
          builder: (context, snapshot) {
            print("snapshot data ${snapshot.data}");
            if (snapshot != null && snapshot.data != null) {
              UiData widgetData = uiDataFromJson(snapshot.data);
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  itemBuilder: (BuildContext ctx, int index) {

                    return Container();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemCount: widgetData.payload.data[0].fieldConfiguration.length,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.get_app),
        onPressed: () {
          //WidgetGenerator.printData();
        },
      ),
    );
  }
}

class Item {
  final String id;
  final String name;

  Item(this.id, this.name);
}
