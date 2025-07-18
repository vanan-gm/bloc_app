import 'package:flutter/material.dart';

class MultiValueListenerBuilder extends StatefulWidget {
  final List<ValueNotifier> notifiers;
  final Widget Function(BuildContext context, List values) builder;

  const MultiValueListenerBuilder({
    super.key,
    required this.notifiers,
    required this.builder,
  });

  @override
  _MultiValueListenerBuilderState createState() => _MultiValueListenerBuilderState();
}

class _MultiValueListenerBuilderState extends State<MultiValueListenerBuilder> {
  late List listeners;

  @override
  void initState() {
    super.initState();
    _setupListeners();
  }

  void _setupListeners() {
    listeners = widget.notifiers
        .map((notifier) {
      void listener() => setState(() {});
      notifier.addListener(listener);
      return listener;
    })
        .toList();
  }

  @override
  void didUpdateWidget(MultiValueListenerBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.notifiers != widget.notifiers) {
      // Remove old listeners
      for (int i = 0; i < oldWidget.notifiers.length; i++) {
        oldWidget.notifiers[i].removeListener(listeners[i]);
      }
      // Setup new ones
      _setupListeners();
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.notifiers.length; i++) {
      widget.notifiers[i].removeListener(listeners[i]);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final values = widget.notifiers.map((n) => n.value).toList();
    return widget.builder(context, values);
  }
}
