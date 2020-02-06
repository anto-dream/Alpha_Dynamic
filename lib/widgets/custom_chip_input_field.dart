import 'package:flutter/material.dart';
import 'package:flutter_dyn_render/bloc/blocBase.dart';

typedef Tapped<T> = void Function();
typedef ChipsBuilder<T> = Widget Function(
    BuildContext context, _CustomChipInputState<T> state, T data);

class CustomChipInput<T> extends StatefulWidget {
  final String label;
  final Tapped<T> onTapped;
  final Set<T> chips;
  @required
  final ChipsBuilder<T> chipsBuilder;
  BlocBase block;

  CustomChipInput(
      {Key key, this.label, this.onTapped, this.chipsBuilder, this.chips, this.block})
      : super(key: key);

  @override
  _CustomChipInputState<T> createState() => _CustomChipInputState<T>();
}

class _CustomChipInputState<T> extends State<CustomChipInput<T>> {
  bool updated = false;
  var chipsChildren  = List<Widget>();

  @override
  void initState() {
    super.initState();
    if (widget.chips != null && widget.chips.length > 0) {
      updated = true;
    } else {
      updated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chips != null) {
      chipsChildren = widget.chips
          .map<Widget>((data) => widget.chipsBuilder(context, this, data))
          .toList();
    }

    return Center(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: GestureDetector(
              onTap: () {
                widget.onTapped();
                if (!updated) {
                  setState(() {
                    updated = true;
                  });
                }
              },
              child: Container(
                  constraints: BoxConstraints(minHeight: 70.0),
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: updated ? Colors.blue : Colors.grey,
                          width: updated ? 2.0 : 1.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: chipsChildren,
                      ),
                    ],
                  )),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            top: updated ? -3.0 : 28,
            left: updated ? 12.0 : 15,
            child: GestureDetector(
              onTap: () {
                widget.onTapped();
                if (!updated) {
                  setState(() {
                    updated = true;
                  });
                }
              },
              child: Container(
                  color: Colors.white,
                  child: Text(
                    widget.label,
                    style: TextStyle(
                        fontSize: updated
                            ? Theme.of(context).textTheme.body2.fontSize
                            : Theme.of(context).textTheme.subhead.fontSize,
                        color: updated ? Colors.blue : Colors.grey),
                  )),
            ),
          )
        ],
      ),
    );
  }

  void deleteChip(T data) {
    setState(() {
      widget.chips.remove(data);
    });

    if (widget.chips.length > 0) {
      updated = true;
    } else {
      updated = false;
    }
  }
}
