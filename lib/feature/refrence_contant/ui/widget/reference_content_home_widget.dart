import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/home/ui/widget/home_service_title_widget.dart';
import 'package:krishi_hub/feature/refrence_contant/cubit/reference_content_cubit.dart';
import 'package:krishi_hub/feature/refrence_contant/model/reference_content_model.dart';
import 'package:krishi_hub/feature/refrence_contant/ui/widget/home_reference_content_card.dart';

class ReferenceContentHomeWidget extends StatelessWidget {
  const ReferenceContentHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ReferenceContentCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonError) {
              return Center(child: Text(state.message));
            } else if (state is CommonLoading) {
              return const ListViewPlaceHolder(
                numberofItem: 1,
                itemHeight: 120,
              );
            } else if (state is CommonNoData) {
              return Center(
                child: Text(
                  LocaleKeys.noDataFound.tr(),
                ),
              );
            } else if (state is CommonDataFetchSuccess<ReferenceContentModel>) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                          state.data.length,
                          (index) => HomeReferenceContentCard(
                                data: state.data[index],
                              ))),
                ),
              );
            }

            return SizedBox();
          },
        )
      ],
    ));
  }
}
