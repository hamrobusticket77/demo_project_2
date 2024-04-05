import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';

import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_view_button.dart';

import 'package:krishi_hub/feature/phone_book/model/phone_book_model.dart';

class PhoneBookCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final PhoneBookModel phoneBookModel;
  final Function() onPressed;
  final int index;
  const PhoneBookCard({
    Key? key,
    required this.phoneBookModel,
    required this.onPressed,
    this.margin,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 5.hp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommonCardWrapper(
            margin:
                margin ?? EdgeInsets.symmetric(horizontal: 0, vertical: 5.hp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.hp),
                Text('${index + 1}. ${phoneBookModel.title}',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                CustomViewIcons(
                  onpress: onPressed,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
