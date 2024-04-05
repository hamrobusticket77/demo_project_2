import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/bottom_navigation_bar_wrapper.dart';
import 'package:krishi_hub/common/widget/button/custom_outline_button.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/demand/cubit/demand_cubit.dart';
import 'package:krishi_hub/feature/demand/model/demand_model.dart';
import 'package:krishi_hub/feature/demand/ui/page/apply_demand_page.dart';
import '../../../../common/widget/app_bar/custom_app_bar.dart';

class DemandDetailWidget extends StatelessWidget {
  const DemandDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.details.tr(),
      ),
      bottomNavigationBar: BlocBuilder<DemandCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonStateSuccess<DemandModel>) {
            return BottomNavigationBarWrapper(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(CustomTheme.symmetricHozPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomOutlineButton(
                          name: LocaleKeys.apply.tr(),
                          onPressed: () {
                            NavigationService.push(
                                    target: ApplyDemandPage(id: state.data.id))
                                .then((value) {
                              if (value != null && value) {
                                context
                                    .read<DemandCubit>()
                                    .getDemandById(state.data.id);
                              }
                            });
                          },
                          fontSize: 13,
                          verticalPadding: 5,
                          sufixIcon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<DemandCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoading) {
              return const ContentPlaceHolder();
            } else if (state is CommonError) {
              return CommonErrorWidget(
                message: state.message,
              );
            }
            if (state is CommonStateSuccess<DemandModel>) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20.hp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: CustomTheme.symmetricHozPadding.wp,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            LocaleKeys.details.tr(),
                            style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          CommonCardWrapper(
                            margin: EdgeInsets.symmetric(vertical: 10.hp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.hp),
                                TextTileWidget(
                                  title: LocaleKeys.fiscalYear.tr(),
                                  subTitle: state.data.fiscalYear.fiscalYear
                                      .toNepali(),
                                ),
                                TextTileWidget(
                                  title: LocaleKeys.project.tr(),
                                  subTitle: state.data.project.title,
                                ),
                                TextTileWidget(
                                  title: LocaleKeys.program.tr(),
                                  subTitle: state.data.project.title,
                                ),
                                TextTileWidget(
                                  title: LocaleKeys.date.tr(),
                                  subTitle:
                                      "${state.data.startDate.toNepali()}  -  ${state.data.endDate.toNepali()}",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.hp,
                          ),
                          if (state.data.quantityDetails.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "${LocaleKeys.subsidyDetails.tr()}:",
                                  style: textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                ...List.generate(
                                    state.data.quantityDetails.length, (index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      if (state.data.quantityDetails[index]
                                          .appliedDemand.isNotEmpty)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            SizedBox(height: 10.hp),
                                            Text(
                                              "${LocaleKeys.subsidyFor.tr()}:  ${state.data.quantityDetails[index].subCategory.name}",
                                              style: textTheme.titleLarge!
                                                  .copyWith(
                                                      color: CustomTheme
                                                          .primaryColor),
                                            ),
                                            ...List.generate(
                                              state.data.quantityDetails[index]
                                                  .appliedDemand.length,
                                              (i) {
                                                final data = state
                                                    .data
                                                    .quantityDetails[index]
                                                    .appliedDemand[i];
                                                return CommonCardWrapper(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10.hp),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      TextTileWidget(
                                                          title: LocaleKeys
                                                              .farmerName
                                                              .tr(),
                                                          subTitle: data
                                                              .farmer
                                                              .farmerPersonalInformation
                                                              .getFullFarmerName),
                                                      TextTileWidget(
                                                          title: LocaleKeys
                                                              .appliedQuantity
                                                              .tr()
                                                              .tr(),
                                                          subTitle: data
                                                                  .appliedQuantity
                                                                  ?.toString()
                                                                  .toNepali() ??
                                                              ""),
                                                      TextTileWidget(
                                                          title: LocaleKeys
                                                              .grantedQuantity
                                                              .tr()
                                                              .tr(),
                                                          subTitle: data
                                                                  .grantedQuantity
                                                                  ?.toString()
                                                                  .toNepali() ??
                                                              ""),
                                                      TextTileWidget(
                                                          title: LocaleKeys
                                                              .grantDate
                                                              .tr()
                                                              .tr(),
                                                          subTitle: data
                                                                  .grantDate
                                                                  ?.toString()
                                                                  .toNepali() ??
                                                              ""),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                    ],
                                  );
                                })
                              ],
                            ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).padding.bottom + 50.hp,
                          )
                        ],
                      ),
                    ),
                  ]);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
