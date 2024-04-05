import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';

class CommonExpandableWidget extends StatefulWidget {
  final Widget header;
  final Widget body;
  final bool? isExpanded;

  final Color? bgColor;

  const CommonExpandableWidget({
    super.key,
    required this.body,
    this.bgColor,
    this.isExpanded,
    required this.header,
  });

  @override
  State<CommonExpandableWidget> createState() =>
      _ExpandableServiceWidgetState();
}

class _ExpandableServiceWidgetState extends State<CommonExpandableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    if (widget.isExpanded != null) {
      _isExpanded = widget.isExpanded!;
      _controller.forward();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor ?? CustomTheme.white,
      child: Column(
        children: <Widget>[
          InkWell(
            radius: 10,
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.all(3),
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [widget.header],
                    ),
                  ),
                  RotationTransition(
                      turns: Tween(begin: 0.0, end: -0.5).animate(_controller),
                      child: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: CustomTheme.grey,
                        size: 22,
                      )),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: _controller,
            child: widget.body,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
