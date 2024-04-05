import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';

class MonthCardWidget extends StatefulWidget {
  final Color color;

  final String month;
  final String timePeriod;
  const MonthCardWidget({
    super.key,
    required this.color,
    required this.month,
    required this.timePeriod,
  });

  @override
  State<MonthCardWidget> createState() => _MonthCardWidgetState();
}

class _MonthCardWidgetState extends State<MonthCardWidget> {
  final Duration _animationDuration = const Duration(seconds: 1);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AnimatedContainer(
      duration: _animationDuration,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.color,
          border: Border.all(
            color: CustomTheme.lightGray,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              widget.month,
              textAlign: TextAlign.center,
              style: textTheme.labelLarge,
            ),
          ),
          Container(
            color: CustomTheme.lightGray,
            height: 1,
          ),
          Expanded(
            child: AnimatedContainer(
              duration: _animationDuration,
              color: widget.color,
              child: Center(
                child: Text(
                  widget.timePeriod,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium!.copyWith(fontSize: 11),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
