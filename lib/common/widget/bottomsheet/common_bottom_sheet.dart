import 'package:flutter/material.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/bottomsheet/bottom_sheet_wrapper.dart';
import 'package:krishi_hub/common/widget/dropdown/common_dropdown_type.dart';

showCommonBottomSheet({
  required BuildContext context,
  required String title,
  required ValueChanged<CommonDropDownType> onChange,
  required List<CommonDropDownType> valueList,
}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) => CommonBottomSheetMultiLang(
            title: title,
            onChange: onChange,
            valueList: valueList,
          ));
}

class CommonBottomSheetMultiLang extends StatelessWidget {
  final String title;
  final ValueChanged<CommonDropDownType> onChange;
  final List<CommonDropDownType> valueList;
  const CommonBottomSheetMultiLang(
      {super.key,
      required this.title,
      required this.onChange,
      required this.valueList});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BottomSheetWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title :",
              style: textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 18.hp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                valueList.length,
                (index) => CommonCardWrapper(
                      onTap: () {
                        onChange(valueList[index]);
                        NavigationService.pop();
                      },
                      margin: const EdgeInsets.all(5),
                      child: SizedBox(
                        child: Row(
                          children: [
                            SizedBox(width: 10.hp),
                            Text(
                              CheckLocal.check(MultiLanguage(
                                      en: valueList[index].en,
                                      ne: valueList[index].ne))
                                  .capitalize()
                                  .replaceAll("_", " "),
                              style: textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
