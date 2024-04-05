import 'package:flutter/material.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';

class ViewImagesWidget extends StatelessWidget {
  final List<String> images;
  const ViewImagesWidget({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Images",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(images.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: CustomNetWorkImage(
                  height: 100.hp,
                  imageUrl: images[index],
                ),
              );
            }),
          ),
        ));
  }
}
