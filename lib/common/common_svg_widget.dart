import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class CommonSvgWidget extends StatelessWidget {
  final String svgName;
  final double height;
  final double width;
  final Color? color;
  const CommonSvgWidget({
    super.key,
    required this.svgName,
    this.height = 16,
    this.width = 16,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      child: SvgPicture.asset(
        svgName,
        height: height.hp,
        width: width.wp,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
