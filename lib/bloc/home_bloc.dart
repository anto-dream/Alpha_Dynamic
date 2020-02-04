import 'package:flutter_dyn_render/bloc/blocBase.dart';
import 'package:flutter_dyn_render/models/event.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  BehaviorSubject<RxEvent> subject = BehaviorSubject();
  BehaviorSubject<RxEvent> _navigationEvents = BehaviorSubject();

  @override
  void dispose() {
    subject.close();
    _navigationEvents.close();
  }

  BehaviorSubject<RxEvent> get navigationEvents => _navigationEvents;
}
