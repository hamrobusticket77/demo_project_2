import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/widget/glass_morphism.dart';

class KrishiCards extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final String imageUrl;
  final double iconHeight;
  final double iconWidth;
  final String date;
  final EdgeInsetsGeometry? margin;

  const KrishiCards({
    Key? key,
    required this.title,
    this.onPressed,
    required this.imageUrl,
    required this.date,
    this.margin,
    this.iconHeight = 30,
    this.iconWidth = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: CustomTheme.white,
            borderRadius: BorderRadius.circular(5),
            // image: DecorationImage(
            //   image: NetworkImage(imageUrl),
            //   fit: BoxFit.cover,
            // ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 2,
                color: CustomTheme.lightGray,
              )
            ],
          ),
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomCachedNetworkImage(
                  fit: BoxFit.cover,
                  url: imageUrl,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GlassMorphism(
                  end: 0.1,
                  start: 0.1,
                  borderRadiusBottom: 5,
                  borderRadiusTop: 0,
                  child: Container(
                    color: Theme.of(context).shadowColor.withOpacity(0.2),
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        // fontSize: 11,
                        color: Colors.white, // Text color
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
