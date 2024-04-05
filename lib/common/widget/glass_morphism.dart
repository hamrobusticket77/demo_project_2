import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;
  final double borderRadiusTop;
  final double borderRadiusBottom;
  const GlassMorphism({
    Key? key,
    required this.child,
    required this.start,
    required this.end,
    this.borderRadiusTop = 0,
    this.borderRadiusBottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(borderRadiusBottom),
        bottomRight: Radius.circular(borderRadiusBottom),
        topLeft: Radius.circular(borderRadiusTop),
        topRight: Radius.circular(borderRadiusTop),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.withOpacity(start),
                Colors.green.withOpacity(end),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadiusBottom),
              bottomRight: Radius.circular(borderRadiusBottom),
              topLeft: Radius.circular(borderRadiusTop),
              topRight: Radius.circular(borderRadiusTop),
            ),
            border: Border.all(
              width: 0.4,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
