import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/glass_morphism.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/krishi_knowledge/constant/agriculture_knowledge_type.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_agriculture_knowledge_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/common_agriculture_knowledge_model.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/all_agriculture_knowledge_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/pages/view_agriculture_detail_page.dart';

class CommomAgricultureTypeKnowledgeWidget extends StatefulWidget {
  final KnowledgetTypeModel data;
  const CommomAgricultureTypeKnowledgeWidget({
    super.key,
    required this.data,
  });

  @override
  _AnimalHusbandaryKnowledgeWidgetState createState() =>
      _AnimalHusbandaryKnowledgeWidgetState();
}

class _AnimalHusbandaryKnowledgeWidgetState
    extends State<CommomAgricultureTypeKnowledgeWidget> {
  bool _isLoadMoreActive = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final allAgriculture =
        RepositoryProvider.of<AllAgricultureKnowledgeRepository>(context)
            .getAgricultureKNowledge;

    return BlocListener<GetAgricultureKnowledgeCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          setState(() {
            _isLoadMoreActive = false;
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: CheckLocal.check(widget.data.appbarTitle),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<GetAgricultureKnowledgeCubit, CommonState>(
            buildWhen: (context, state) {
              if (state is CommonDummyLoading) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state is CommonLoading) {
                return ListViewPlaceHolder(
                  itemHeight: 100.hp,
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
                    if (scrollNotification.metrics.pixels >
                        scrollNotification.metrics.maxScrollExtent / 2) {}
                    return true;
                  },
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.hp, horizontal: 8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 8.hp,
                    ),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final agricultureId = state.data[index];
                      final data = allAgriculture[agricultureId];
                      if (data != null) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              NavigationService.push(
                                target: AgricultureDetailPage(
                                  data: widget.data,
                                  agricultureKnowledgeModel: data,
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: CustomTheme.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    color: CustomTheme.lightGray,
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.all(0),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: CustomCachedNetworkImage(
                                      fit: BoxFit.cover,
                                      url: data.media.medias.first.path,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: GlassMorphism(
                                      end: 0.1,
                                      start: 0.1,
                                      borderRadiusBottom: 5,
                                      borderRadiusTop: 0,
                                      child: Container(
                                          color: Colors.black.withOpacity(0.2),
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Text(
                                                data.category.name,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: textTheme.titleLarge!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                data.name.name,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: textTheme.titleLarge!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
