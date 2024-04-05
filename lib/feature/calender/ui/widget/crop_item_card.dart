import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/calender/model/calender_model.dart';

class CropItemCard extends StatelessWidget {
  final Function() onChange;
  final CalenderModel data;
  final String id;
  final String selectedId;
  const CropItemCard({
    super.key,
    required this.data,
    required this.onChange,
    required this.id,
    required this.selectedId,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      child: Material(
        elevation: 0.5,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: onChange,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: id == selectedId
                    ? Theme.of(context).primaryColor
                    : CustomTheme.lighterGrey,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomNetWorkImage(
                        imageUrl: data.media.path,
                        boxFit: BoxFit.cover,
                        height: 60.hp,
                      ),
                    ),
                    SizedBox(
                      width: 10.wp,
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        data.name.name,
                        style: textTheme.bodyLarge,
                      ),
                    ),
                  ],
                )
                // Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
