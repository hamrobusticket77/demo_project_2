import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_home_krishi_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/pages/view_all_data_page.dart';

import 'krishi_card.dart';

class KrishiWidget extends StatelessWidget {
  const KrishiWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<GetHomeKrishiCubit, CommonState>(
        buildWhen: (context, state) {
          if (state is CommonDummyLoading) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is CommonLoading) {
            return SizedBox(
              child: ListViewPlaceHolder(
                itemHeight: 100.hp,
                numberofItem: 1,
              ),
            );
          } else if (state is CommonError) {
            return CommonErrorWidget(
              hideImage: true,
              message: state.message,
            );
          } else if (state is CommonNoData) {
            return Center(child: Text((LocaleKeys.noDataFound.tr())));
          } else if (state is CommonDataFetchSuccess<AgricultureName>) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(vertical: 5.hp, horizontal: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 8.hp,
              ),
              itemCount: state.data.length > 6 ? 6 : state.data.length,
              itemBuilder: (context, index) {
                final data = state.data[index];

                // ignore: unnecessary_null_comparison
                if (data != null) {
                  return KrishiCards(
                    onPressed: () {
                      NavigationService.push(
                          target: ViewAllDataPage(
                        agricultureName: data,
                      ));
                    },
                    date: data.title.localize(),
                    imageUrl: data.media.medias.first.path,
                    title: data.name.name,
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
