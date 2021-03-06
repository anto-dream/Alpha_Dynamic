import 'package:flutter/material.dart';
import 'package:flutter_dyn_render/assets/uidata.dart';
import 'package:flutter_dyn_render/bloc/home_bloc.dart';
import 'package:flutter_dyn_render/bloc/inheritedWidget.dart';
import 'package:flutter_dyn_render/models/event.dart';
import 'package:flutter_dyn_render/models/navigation.dart';
import 'package:flutter_dyn_render/models/ui_data.dart';
import 'package:flutter_dyn_render/widgetGenerator.dart';
import 'package:flutter_dyn_render/widgets/default_search_page.dart';
import 'package:flutter_dyn_render/widgets/multiselect_chip_select_search.dart';

import 'constants.dart';

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
  HomeBloc bloc = HomeBloc();
  List<Item> itemList = [
    Item("ID1", "First product"),
    Item("ID2", "Second product"),
  ];

  Map<String, int> quantities = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Scaffold(
        appBar: AppBar(title: Text("Demo")),
        body: FutureBuilder<String>(
            future: UiResponse().loadAsset(),
            builder: (context, snapshot) {
              // print("snapshot data ${snapshot.data}");
              if (snapshot != null && snapshot.data != null) {
                UiData widgetData = uiDataFromJson(snapshot.data);
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemBuilder: (BuildContext ctx, int index) {
                      return WidgetGenerator.generateWidget(bloc,
                          widgetData.payload.data[0].fieldConfiguration[index]);
                    },
                    itemCount:
                        widgetData.payload.data[0].fieldConfiguration.length,
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
      ),
      bloc: bloc,
    );
  }

  @override
  void initState() {
    initialiseListeners();
    super.initState();
  }

  void initialiseListeners() {
    bloc.navigationEvents.listen((RxEvent event) {
      if (event.type == RxConstants.SCREEN_NAVIGATION) {
        var routePage;
        switch (event.data.displayGroups[0].fields[0].controlType) {
          case TypeConstants.SINGLE_SELECT:
            routePage = DefaultSearchPage(event.data);
            break;
          case TypeConstants.MULTI_SELECT:
            routePage = MultiSelectChipSearchPage(event.data);
            break;
        }
        //Dismiss keyboard
        FocusScope.of(context).requestFocus(new FocusNode());
        launch(routePage);
      }
    });
  }

  void launch(Widget routePage) async {
    RouteData result = await Navigator.of(context)
        .push<RouteData>(MaterialPageRoute(builder: (ctx) => routePage));
    if (result != null) {
      switch (result.fieldConfiguration.displayGroups[0].fields[0].controlType) {
        case TypeConstants.SINGLE_SELECT:
          bloc.dataUpdater.add(RxEvent(RxConstants.DATA_UPDATE,
              data: result.fieldConfiguration, widgetData: result.dataOpted));
          break;
        case TypeConstants.MULTI_SELECT:
          print("popoed");
          bloc.dataUpdater.add(RxEvent(RxConstants.DATA_UPDATE,
              data: result.fieldConfiguration, widgetData: result.dataOpted));
          break;
      }
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

class Item {
  final String id;
  final String name;

  Item(this.id, this.name);
}
