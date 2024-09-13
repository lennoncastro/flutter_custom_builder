import 'package:flutter/widgets.dart';

import 'custom_notifier.dart';

class CustomBuilder<T> extends StatefulWidget {
  const CustomBuilder(
    this.builder, {
    this.when,
    required this.notifier,
    super.key,
  });

  final Future<bool> Function(T value)? when;

  final CustomNotifier<T> notifier;

  final Widget Function(BuildContext context, T value) builder;

  @override
  State<StatefulWidget> createState() {
    return _CustomBuilderState<T>();
  }
}

class _CustomBuilderState<T> extends State<CustomBuilder<T>> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      widget.notifier.addListener(_callback);
    }
  }

  void _callback() {
    if (widget.when == null) setState(() {});
    widget.when?.call(widget.notifier.value).then((bool shouldUpdate) {
      if (!shouldUpdate) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_callback);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.notifier.value);
  }
}
