import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'package:krishi_hub/feature/organization_structure/cubit/get_organization_cubit.dart';
import 'package:krishi_hub/feature/organization_structure/resources/all_organzation_repository.dart';
import '../../../../common/common_error_widget.dart';
import '../../../../common/common_nodata_widget.dart';
import '../../../../common/constant/locale_keys.dart';
import '../../../../common/cubit/data_state.dart';
import '../../../../common/widget/app_bar/custom_app_bar.dart';
import '../../../../common/widget/shimmer/shimmer_widget.dart';
import 'organization_card.dart';

class OrganizationListWidget extends StatefulWidget {
  const OrganizationListWidget({super.key});

  @override
  State<OrganizationListWidget> createState() => _NewsListWigetState();
}

class _NewsListWigetState extends State<OrganizationListWidget> {
  // @override
  // void initState() {

  //   context.read<GetNewsCubit>().getNews();
  //   super.initState();
  // }
  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final allNews = RepositoryProvider.of<AllOrginazationRepository>(context)
        .getOrganizationStructure;
    return BlocListener<GetOrganizationCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          setState(() {
            _isLoadMoreActive = false;
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.organizationstructure.tr(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetOrganizationCubit, CommonState>(
                buildWhen: (context, state) {
                  if (state is CommonDummyLoading) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state is CommonLoading) {
                    return ListViewPlaceHolder(
                      itemHeight: 200.hp,
                    );
                  } else if (state is CommonError) {
                    return CommonErrorWidget(
                      message: state.message,
                    );
                  } else if (state is CommonNoData) {
                    return const Center(child: CommonNoDataWidget());
                  } else if (state is CommonDataFetchSuccess<String>) {
                    return NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          // if (scrollNotification.metrics.pixels >
                          //     scrollNotification.metrics.maxScrollExtent / 2) {
                          //   if (!_isLoadMoreActive &&
                          //       _scrollController
                          //               .position.userScrollDirection ==
                          //           ScrollDirection.reverse) {
                          //     _isLoadMoreActive = true;
                          //     context.read<FAQCubit>().loadMoreFaq();
                          //   }
                          // }
                          return true;
                        },
                        child: Column(
                            children: List.generate(state.data.length, (index) {
                          final data = allNews[state.data[index]];

                          if (data != null) {
                            return InkWell(
                              onTap: () {
                                viewImageDialog(
                                    context, data.media.medias.first.path);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  width: 0.5,
                                )),
                                margin: EdgeInsets.symmetric(
                                  vertical: 10.hp,
                                  horizontal:
                                      CustomTheme.symmetricHozPadding.wp,
                                ),
                                height: 200.hp,
                                child: OrganizationCard(
                                  organizationModel: data,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        })));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}
