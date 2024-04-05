import 'package:flutter/material.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/images/model/image_album_model.dart';

import '../../../../common/app/theme.dart';
import '../../../../common/common_card_wapper.dart';

class AlbumCard extends StatelessWidget {
  final Function()? onPressed;

  final EdgeInsetsGeometry? margin;

  final ImageAlbumModel model;

  const AlbumCard({
    super.key,
    required this.model,
    required this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonCardWrapper(
      onTap: onPressed,
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          model.title,
                          style: textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
