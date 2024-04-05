import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/dismissable_wrapper_widget.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/agriculture_plan/constant/farmer_type.dart';
import 'package:krishi_hub/feature/agriculture_plan/cubit/delete_agriculture_plan.dart';
import 'package:krishi_hub/feature/agriculture_plan/cubit/get_agriculture_plan_cubit.dart';
import 'package:krishi_hub/feature/agriculture_plan/model/agriculture_plan_model.dart';
import 'package:krishi_hub/feature/agriculture_plan/ui/pages/agriculture_plan_form_page.dart';
import 'package:krishi_hub/feature/agriculture_plan/ui/widget/delete_plan_dialog.dart';

class AgricultureCard extends StatelessWidget {
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final AgriculturePlanModel agriculturelistModel;

  const AgricultureCard({
    super.key,
    required this.agriculturelistModel,
    required this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return DismissableWrapper(
      onConfirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await deleteNewDialog(
              context: context,
              onPressed: () {
                context
                    .read<DeleteAgricluturePlan>()
                    .deleteAgriculturePlan(id: agriculturelistModel.id);
              }).then((value) {
            if (value != null && value) {
              return true;
            } else {
              return false;
            }
          });
        } else {
          NavigationService.push(
              target: AgriculturePlanFormPage(
            agriculturelistModel: agriculturelistModel,
          )).then((value) {
            if (value != null && value) {
              context.read<GetAgricultureCubit>().getAgriculturePlan();
            }
          });
          return false;
        }
      },
      id: agriculturelistModel.id,
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // context.read<GetNewsCubit>().getNews();
        }
      },
      child: CommonCardWrapper(
        onTap: onPressed,
        margin: margin ??
            EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding.wp,
                vertical: 10.hp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTileWidget(
              title: LocaleKeys.fiscalYear.tr(),
              subTitle: agriculturelistModel.fiscalYear.fiscalYear,
            ),
            TextTileWidget(
              title: LocaleKeys.program.tr(),
              subTitle: agriculturelistModel.program.title,
            ),
            TextTileWidget(
              title: LocaleKeys.framertype.tr(),
              subTitle: CheckLocal.check(
                GroupType.getFarmerMultiLang(agriculturelistModel.farmerType),
              ),
            ),
            TextTileWidget(
              title: LocaleKeys.project.tr(),
              subTitle: agriculturelistModel.program.title,
            ),
          ],
        ),
      ),
    );
  }
}
