import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/feature/calender/constant/calender_constant.dart';
import 'package:krishi_hub/feature/project/cubit/fiscal_year_cubit.dart';
import 'package:krishi_hub/common/widget/common_drop_down_wrapper.dart';

Future ecologicalDialog({
  required BuildContext context,
  required ValueChanged<MultiLanguage> onChange,
}) async {
  showDialog(
      context: context,
      builder: ((context) => EcologicalDialog(
            onChange: onChange,
          )));
}

class EcologicalDialog extends StatefulWidget {
  final ValueChanged<MultiLanguage> onChange;

  const EcologicalDialog({
    super.key,
    required this.onChange,
  });

  @override
  State<EcologicalDialog> createState() => _FiscalYearDialogState();
}

class _FiscalYearDialogState extends State<EcologicalDialog> {
  @override
  void initState() {
    final bloc = context.read<FiscalYearCubit>();
    if (bloc.state is CommonLoading || bloc.state is CommonStateSuccess) {
    } else {
      bloc.getCurrentFiscalYear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonDropDownWrapper(
        title: LocaleKeys.ecologicalRegion.tr(),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                  CalenderConstant.ecologicalAreaList.length, (index) {
                final data = CalenderConstant.ecologicalAreaList[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                      // color: CustomTheme.lightGray,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          widget.onChange(data);
                          NavigationService.pop();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              child: Text(
                                CheckLocal.check(data),
                                style: textTheme.bodyLarge,
                              ),
                            ),
                            const Divider()
                          ],
                        ),
                      )),
                );
              })),
        ));
  }
}
