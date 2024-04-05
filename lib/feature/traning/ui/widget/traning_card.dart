import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/glass_morphism.dart';
import 'package:krishi_hub/feature/traning/model/training_model.dart';

class TraningCard extends StatelessWidget {
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final TrainingModel traningModel;

  const TraningCard({
    super.key,
    required this.traningModel,
    required this.onPressed,
    this.margin,
  });

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
            // image: (traningModel.media != null &&
            //         traningModel.media!.path.isNotEmpty)
            //     ? DecorationImage(
            //         image: NetworkImage(traningModel.media!.path),
            //         fit: BoxFit.cover)
            //     : const DecorationImage(
            //         image: AssetImage(
            //           Assets.placeholder,
            //         ),
            //         fit: BoxFit.cover),
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
                  url: (traningModel.media != null &&
                          traningModel.media!.path.isNotEmpty)
                      ? traningModel.media!.path
                      : "",
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: traningModel.trainingApplicants.isNotEmpty
                    ? CustomIconButton(
                        icon: Icons.check,
                        verticalPadding: 0,
                        horizontalPadding: 0,
                        iconColor: Theme.of(context).colorScheme.tertiary,
                        iconSize: 15,
                      )
                    : const SizedBox(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: CustomTheme.white,
                  child: GlassMorphism(
                    end: 0.3,
                    start: 0.3,
                    borderRadiusBottom: 5,
                    borderRadiusTop: 0,
                    child: Container(
                      color: Theme.of(context).shadowColor.withOpacity(0.2),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          // Text(
                          //   traningModel.title,
                          //   textAlign: TextAlign.center,
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: textTheme.bodyLarge!.copyWith(
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 11,
                          //     color: Colors.white, // Text color
                          //   ),
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(traningModel.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.titleLarge!.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: CustomTheme.white,
                                        )),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 5.hp,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     const CommonSvgWidget(
                              //       // height: 10,
                              //       // width: 10,
                              //       svgName: Assets.profile,
                              //       color: CustomTheme.white,
                              //     ),
                              //     SizedBox(width: 5.hp),
                              //     Text(
                              //       traningModel.trainer,
                              //       maxLines: 1,
                              //       overflow: TextOverflow.ellipsis,
                              //       style: textTheme.bodyMedium!.copyWith(
                              //         fontWeight: FontWeight.bold,
                              //         color: CustomTheme.white,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 5.hp,
                              // ),
                            ],
                          ),
                        ],
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
