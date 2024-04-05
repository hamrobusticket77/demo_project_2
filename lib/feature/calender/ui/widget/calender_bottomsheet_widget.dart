import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_outline_button.dart';
import 'package:krishi_hub/feature/calender/cubit/calender_cubit.dart';
import 'package:krishi_hub/feature/calender/cubit/crop_index_change_cubit.dart';
import 'package:krishi_hub/feature/calender/resource/all_calender_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/pages/view_all_data_page.dart';

class CalenderBottomSheetWidget extends StatefulWidget {
  final String cropId;
  const CalenderBottomSheetWidget({
    super.key,
    required this.cropId,
  });

  @override
  State<CalenderBottomSheetWidget> createState() =>
      _CalenderBottomSheetWidgetState();
}

class _CalenderBottomSheetWidgetState extends State<CalenderBottomSheetWidget> {
  double containerHeight = 0;

  bool showContainer = false;

  changeContainerContainer() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      showContainer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final calender =
        RepositoryProvider.of<AllCalenderRepository>(context).getCalender;
    return BlocListener<CropIndexChangeCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonStateSuccess<bool>) {
          if (state.data) {
            containerHeight = 50.hp;
            setState(() {});
            changeContainerContainer();
          } else {
            containerHeight = 0;
            showContainer = false;

            setState(() {});
          }
        }
      },
      child: BlocBuilder<CalenderCubit, CommonState>(
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: containerHeight,
            color: CustomTheme.white,
            padding: EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state is CommonDataFetchSuccess<String> &&
                        showContainer)
                      CustomOutlineButton(
                        onPressed: () {
                          final agricultureName =
                              calender[widget.cropId]?.name.agricultureName;
                          print(agricultureName);
                          if (agricultureName != null) {
                            NavigationService.push(
                              target: ViewAllDataPage(
                                agricultureName: agricultureName,
                              ),
                            );
                          }
                        },
                        name: LocaleKeys.viewDetail.tr(),
                        verticalPadding: 5.hp,
                        sufixIcon: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
