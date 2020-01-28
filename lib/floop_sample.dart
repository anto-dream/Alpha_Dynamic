import 'package:flutter/material.dart';
import 'package:floop/floop.dart';
import 'package:http/http.dart' as http;

class DynamicValues {
  static Widget get image => floop['image'];
  static set image(Widget widget) => floop['image'] = widget;
}

var _fetching = false;

Future<bool> fetchAndUpdateImage([String url = 'https://picsum.photos/300/200']) async {
  if (_fetching) {
    return false;
  }
  try {
    _fetching = true; // locks the fetching function
    final response = await http.get(url);
    DynamicValues.image = TransitionImage(Image.memory(response.bodyBytes));
    return true;
  } finally {
    _fetching = false;
  }
}

class ImageDisplay extends StatelessWidget with Floop {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicValues.image == null
          ? Center(
        child: Text(
          'Loading...',
          textScaleFactor: 2,
        ),
      )
          : Align(
          alignment: Alignment(0, transition(2000, delayMillis: 800) - 1),
          child: DynamicValues.image),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () async {
          DynamicValues.image = null;
          await fetchAndUpdateImage();
          // Restarting context transitions after the new image has loaded
          // causes the new image to also transition from top to center.
          Transitions.restart(context: context);
        },
      ),
    );
  }
}

// `extends FloopWidget` is equivalent to `...StatelessWidget with Floop`.
class TransitionImage extends FloopWidget {
  final Image image;
  const TransitionImage(this.image);

  @override
  Widget build(BuildContext context) {
    // Opacity transitions from 0 to 1 in 1.5 seconds.
    return GestureDetector(
      child: Opacity(opacity: transition(1500), child: image),
      onTap: () async {
        if (await fetchAndUpdateImage()) {
          Transitions.restart(context: context);
        }
      },
    );
  }
}