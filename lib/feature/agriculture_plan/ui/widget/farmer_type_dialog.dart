import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/feature/agriculture_plan/constant/farmer_type.dart';
import 'package:krishi_hub/common/widget/common_drop_down_wrapper.dart';

farmerTypeDialog({
  required BuildContext context,
  required ValueChanged<MultiLanguage> onChange,
}) {
  showDialog(
      context: context,
      builder: ((context) => FarmerTypeDialog(
            onChange: onChange,
          )));
}

class FarmerTypeDialog extends StatefulWidget {
  final ValueChanged<MultiLanguage> onChange;

  const FarmerTypeDialog({
    super.key,
    required this.onChange,
  });

  @override
  State<FarmerTypeDialog> createState() => _FarmerTypeDialogState();
}

class _FarmerTypeDialogState extends State<FarmerTypeDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonDropDownWrapper(
        title: LocaleKeys.chooseFarmerType.tr(),
        child: Column(
          children: [
            ...List.generate(GroupType.groupTypeList.length, (index) {
              final data = GroupType.groupTypeList[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Material(
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {
                        widget.onChange(data);
                        NavigationService.pop();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            child: Text(
                              data.localize(),
                              style: textTheme.bodyLarge,
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                    )),
              );
            })
          ],
        ));
  }
}
