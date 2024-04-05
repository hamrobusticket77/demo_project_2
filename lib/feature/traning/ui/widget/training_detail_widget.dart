import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/date_formater_utils.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'package:krishi_hub/feature/traning/cubit/apply_traning_cubit.dart';
import 'package:krishi_hub/feature/traning/cubit/get_training_details_cubit.dart';
import 'package:krishi_hub/feature/traning/model/training_model.dart';

class TrainingDetailWidget extends StatefulWidget {
  const TrainingDetailWidget({
    super.key,
  });

  @override
  State<TrainingDetailWidget> createState() => _TrainingDetailWidgetState();
}

class _TrainingDetailWidgetState extends State<TrainingDetailWidget> {
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.traningDetail.tr(),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<GetTrainingDetailsCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoading) {
              return const ContentPlaceHolder();
            } else if (state is CommonError) {
              return CommonErrorWidget(message: state.message);
            } else if (state is CommonStateSuccess<TrainingModel>) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CommonCardWrapper(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 5.hp),
                        Text(
                          state.data.title,
                          style: textTheme.bodyLarge!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 10.hp),
                        TextTileWidget(
                          title: LocaleKeys.title.tr(),
                          subTitle: state.data.title,
                        ),
                        TextTileWidget(
                          title: LocaleKeys.startdate.tr(),
                          subTitle: DateFormatterUtils.convertAdIntoBs(
                              state.data.startDate),
                        ),
                        TextTileWidget(
                          title: LocaleKeys.endDate.tr(),
                          subTitle: DateFormatterUtils.convertAdIntoBs(
                              state.data.endDate),
                        ),
                        TextTileWidget(
                          title: LocaleKeys.trainer.tr(),
                          subTitle: state.data.trainer,
                        ),
                        TextTileWidget(
                          title: LocaleKeys.venu.tr(),
                          subTitle: state.data.venue,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (state.data.media != null &&
                                state.data.media!.path.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.image.tr(),
                                    style: textTheme.labelLarge!.copyWith(
                                      color: CustomTheme.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.hp,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      viewImageDialog(
                                          context, state.data.media!.path);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.wp),
                                      child: CustomNetWorkImage(
                                        imageUrl: state.data.media!.path,
                                        boxFit: BoxFit.contain,
                                        height: 120.hp,
                                        width: 120.wp,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        if (state.data.trainingApplicants.isNotEmpty)
                          Column(
                            children: [
                              const Divider(
                                thickness: 0.5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "✅  ${LocaleKeys.youHaveAlreadyAppliedforThisTraining.tr()}",
                                      textAlign: TextAlign.end,
                                      style: textTheme.titleSmall!.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.hp,
                  ),
                  if (state.data.trainingApplicants.isEmpty)
                    BlocListener<ApplyTrainingCubit, CommonState>(
                        listener: (context, state) {
                      if (state is CommonError) {
                        CustomToast.error(message: state.message);
                      }
                      if (state is CommonSuccess) {
                        CustomToast.success(
                          message: LocaleKeys.traningApplySucessfully.tr(),
                        );

                        if (mounted) {
                          Navigator.pop(context, true);
                        }
                      }
                    }, child: BlocBuilder<ApplyTrainingCubit, CommonState>(
                            builder: (context, applyState) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: CustomTheme.symmetricHozPadding.wp,
                        ),
                        child: CustomRoundedButton(
                          title: LocaleKeys.apply.tr(),
                          isLoading: applyState is CommonLoading,
                          onPressed: () {
                            context.read<ApplyTrainingCubit>().applyTraining(
                                  id: state.data.id,
                                );
                          },
                        ),
                      );
                    })),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
