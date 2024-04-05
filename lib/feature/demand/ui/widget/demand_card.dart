import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_outline_button.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/demand/model/demand_model.dart';
import 'package:krishi_hub/feature/demand/ui/page/apply_demand_page.dart';

class DemandListCard extends StatelessWidget {
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final DemandModel demandlistModel;
  const DemandListCard({
    super.key,
    required this.demandlistModel,
    required this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return
        //  DismissableWrapper(
        // onConfirmDismiss: (direction) async {
        //   if (direction == DismissDirection.endToStart) {
        //     return await deleteDemandDialog(
        //         context: context,
        //         onPressed: () {
        //           context
        //               .read<DeleteDemand>()
        //               .deleteAgriculturePlan(id: demandlistModel.id);
        //         }).then((value) {
        //       if (value != null && value) {
        //         return true;
        //       } else {
        //         return false;
        //       }
        //     });
        //   } else {
        //     NavigationService.push(
        //         target: DemandPage(
        //       demand: demandlistModel,
        //     )).then((value) {
        //       if (value != null && value) {
        //         context.read<GetDemandListCubit>().getDemandList();
        //       }
        //     });
        //     return false;
        //   }
        // },
        // id: demandlistModel.id,
        // margin: margin ??
        //     EdgeInsets.symmetric(
        //         horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
        // onDismissed: (direction) {
        //   if (direction == DismissDirection.endToStart) {
        //     // context.read<GetNewsCubit>().getNews();
        //   }
        // },
        // child:
        CommonCardWrapper(
      onTap: onPressed,
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTileWidget(
            title: LocaleKeys.fiscalYear.tr(),
            subTitle: demandlistModel.fiscalYear.fiscalYear.toNepali(),
          ),
          TextTileWidget(
            title: LocaleKeys.program.tr(),
            subTitle: demandlistModel.program.title,
          ),
          TextTileWidget(
            title: LocaleKeys.project.tr(),
            subTitle: demandlistModel.project.title,
          ),
          TextTileWidget(
            title: LocaleKeys.date.tr(),
            subTitle:
                "${demandlistModel.startDate.toNepali()}  -  ${demandlistModel.endDate.toNepali()}",
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomOutlineButton(
                name: LocaleKeys.apply.tr().toUpperCase(),
                verticalPadding: 4,
                fontSize: 13,
                onPressed: () {
                  NavigationService.push(
                      target: ApplyDemandPage(id: demandlistModel.id));
                },
                sufixIcon: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          )
          // TextTileWidget(
          //   title: LocaleKeys.endDate.tr(),
          //   subTitle: demandlistModel.endDate,
          // ),
        ],
      ),
      // ),
    );
  }
}
