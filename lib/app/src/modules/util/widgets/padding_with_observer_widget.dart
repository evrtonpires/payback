import 'package:flutter/material.dart';

class PaddingWithObserverWidget extends StatefulWidget {
  const PaddingWithObserverWidget(
      {Key? key,
      required this.child,
      this.left,
      this.right,
      this.top,
      this.bottom})
      : super(key: key);

  final Widget child;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  @override
  _PaddingWithObserverWidgetState createState() =>
      _PaddingWithObserverWidgetState();
}

class _PaddingWithObserverWidgetState extends State<PaddingWithObserverWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.left ?? MediaQuery.of(context).size.width * .05,
        right: widget.right ?? MediaQuery.of(context).size.width * .05,
        top: widget.top ?? MediaQuery.of(context).size.width * .05,
        bottom: widget.bottom ?? MediaQuery.of(context).size.width * .05,
      ),
      child: widget.child,
    );
  }
}
