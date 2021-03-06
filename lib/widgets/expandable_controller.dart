import 'package:floop/floop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dyn_render/bloc/home_bloc.dart';
import 'package:flutter_dyn_render/models/event.dart';
import 'package:flutter_dyn_render/models/ui_data.dart';
import 'package:rxdart/rxdart.dart';

///controller which can expand on sending event
class ExpandableControllerWidget extends StatefulWidget {
  final bool expand = false;
  final Widget child;
  final BehaviorSubject<RxEvent> subject = BehaviorSubject();

  var bloc;

  FieldConfiguration dataItem;

  ExpandableControllerWidget(this.child, this.dataItem, {this.bloc}) {
    floop['text'] = false;
  }

  @override
  _ExpandableControllerWidgetState createState() =>
      _ExpandableControllerWidgetState();
}

class _ExpandableControllerWidgetState extends State<ExpandableControllerWidget>
    with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;

  @override
  void initState() {
    prepareAnimations();
    initialiseListeners();
    super.initState();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this,
        reverseDuration: Duration(milliseconds: 200),
        duration: Duration(milliseconds: 800));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.easeInOutBack,
    );
  }

  void _runExpandCheck() {
    if (floop['text']) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    widget.subject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizeTransition(
              sizeFactor: animation,
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: widget.child,
              )),
        ],
      ),
    );
  }

  void initialiseListeners() {
    if (widget.bloc is HomeBloc) {
      HomeBloc homeBloc = widget.bloc as HomeBloc;
      homeBloc.dataUpdater.listen((RxEvent event) {
        if (event.type == RxConstants.DATA_UPDATE) {
          print(" event received ${event.widgetData.length}  -- ${event.type}");

          event.widgetData.forEach((val) {
            if (val is Option) {
              if (val.value ==
                  widget.dataItem.conditionals[0].fields[0].value) {
                setState(() {
                  expandController.forward();
                });
              }
            }
          });
        } else if (event.type == RxConstants.MULTI_SELECTION_DELETION) {
          if (event.option.value ==
              widget.dataItem.conditionals[0].fields[0].value) {
            setState(() {
              expandController.reverse();
            });
          }
        }
      });
    }
  }
}
