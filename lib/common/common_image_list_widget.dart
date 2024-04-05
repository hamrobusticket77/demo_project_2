import 'package:flutter/material.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'constant/constant_assets.dart';
import 'image/custom_cache_network_image.dart';

class CommonImageListWidget extends StatelessWidget {
  final List<String> mediaList;
  const CommonImageListWidget({Key? key, required this.mediaList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              mediaList.length,
              (index) {
                final data = mediaList[index];
                return InkWell(
                  onTap: () {
                    viewImageDialog(NavigationService.context, data);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.wp),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.wp),
                      child: CustomCachedNetworkImage(
                        placeholder: Assets.placeholder,
                        fit: BoxFit.cover,
                        url: data,
                        width: 180.wp,
                        height: 150.hp,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
