import 'package:flutter_dyn_render/bloc/blocBase.dart';
import 'package:flutter_dyn_render/models/event.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  BehaviorSubject<RxEvent> _navigationEvents = BehaviorSubject();
  BehaviorSubject<RxEvent> _dataUpdater = BehaviorSubject();

  @override
  void dispose() {
    _navigationEvents.close();
    _dataUpdater.close();
  }

  BehaviorSubject<RxEvent> get navigationEvents => _navigationEvents;

  BehaviorSubject<RxEvent> get dataUpdater => _dataUpdater;


}
