import 'package:flutter/material.dart';

class CustomViewIcons extends StatelessWidget {
  final Function() onpress;
  const CustomViewIcons({
    required this.onpress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onpress,
          child: Icon(
            Icons.remove_red_eye,
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
