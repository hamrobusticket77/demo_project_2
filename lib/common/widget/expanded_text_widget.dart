import 'package:flutter/material.dart';

class ExpandedTextWidget extends StatelessWidget {
  final Text text;
  const ExpandedTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [text],
    );
  }
}
