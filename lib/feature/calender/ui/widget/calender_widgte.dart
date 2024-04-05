import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/bottom_navigation_bar_wrapper.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/feature/calender/constant/calender_constant.dart';
import 'package:krishi_hub/feature/calender/constant/month.dart';
import 'package:krishi_hub/feature/calender/cubit/calender_cubit.dart';
import 'package:krishi_hub/feature/calender/cubit/crop_index_change_cubit.dart';
import 'package:krishi_hub/feature/calender/cubit/echological_region_cubit.dart';
import 'package:krishi_hub/feature/calender/model/calender_month_model.dart';
import 'package:krishi_hub/feature/calender/resource/all_calender_repository.dart';
import 'package:krishi_hub/feature/calender/resource/calender_repository.dart';
import 'package:krishi_hub/feature/calender/ui/widget/calender_bottomsheet_widget.dart';
import 'package:krishi_hub/feature/calender/ui/widget/crop_item_card.dart';
import 'package:krishi_hub/feature/calender/ui/widget/ecological_dialog.dart';
import 'package:krishi_hub/feature/calender/ui/widget/month_card_widgtet.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';
import 'package:krishi_hub/feature/crop_type/ui/widget/crop_categories_dialog.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  String _selectedCropId = "";

  // String id = "";

  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();

  MultiLanguage? _selectedEcologicalRegion;

  CropTypeModel? selectedCropType;

  List<CalenderMonthModel> calenderMonthModel = [];

  final TextEditingController ecologicalRegion = TextEditingController();
  final TextEditingController cropType = TextEditingController();

  _onChangeIndex(String index) {
    setState(() {
      _selectedCropId = index;
    });

    context
        .read<EcologicalRegionCubit>()
        .onChangeEcologicalRegion(_selectedEcologicalRegion?.en ?? "", index);
  }

  @override
  void initState() {
    ecologicalRegion.text = CheckLocal.isEnglish()
        ? CalenderConstant.teraiEn
        : CalenderConstant.teraiNe;

    calenderMonthModel = List.generate(
      12,
      (index) => CalenderMonthModel(
        index: index,
        color: CustomTheme.white,
        timePeriod: "",
      ),
    );

    _selectedEcologicalRegion = CalenderConstant.ecologicalAreaList[1];
    _selectedCropId = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // cropType.text =
    //     "hellaosjdflka asdlkfj adlkf jadslkjfslakjsf  asldkjf aslkdjf lskdjf lksadjf ";
    // final textTheme = Theme.of(context).textTheme;
    final calednerList =
        RepositoryProvider.of<AllCalenderRepository>(context).getCalender;

    return BlocListener<EcologicalRegionCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonSuccess) {
            calenderMonthModel = [];
            calenderMonthModel =
                RepositoryProvider.of<CalenderRepository>(context)
                    .calenderMonthModel;
            setState(() {});
          }
        },
        child: Scaffold(
          backgroundColor: CustomTheme.lightGray,
          appBar: CustomAppBar(
            title: LocaleKeys.calenderTitle.tr(),
          ),
          bottomNavigationBar: BottomNavigationBarWrapper(
            child: CalenderBottomSheetWidget(
              cropId: _selectedCropId,
            ),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels >
                  scrollNotification.metrics.maxScrollExtent / 2) {
                if (!_isLoadMoreActive &&
                    _scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                  _isLoadMoreActive = true;
                }
              }
              return true;
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding.wp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.hp),
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: ecologicalRegion,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            isReadOnly: true,
                            onTap: () {
                              ecologicalDialog(
                                  context: context,
                                  onChange: (value) {
                                    ecologicalRegion.text =
                                        CheckLocal.check(value);
                                    _selectedEcologicalRegion = value;
                                    setState(() {});
                                    context
                                        .read<EcologicalRegionCubit>()
                                        .onChangeEcologicalRegion(
                                            value.en ?? "", _selectedCropId);
                                  }).whenComplete(() {
                                // if (_selectedEcologicalRegion != null) {}
                              });
                            },
                            suffixIcon: const Icon(Icons.keyboard_arrow_down),
                            hintText: LocaleKeys.region.tr(),
                          ),
                        ),
                        SizedBox(width: 10.wp),
                        Expanded(
                            child: CustomTextField(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          isReadOnly: true,
                          hintText: LocaleKeys.cropType.tr(),
                          controller: cropType,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down),
                          onTap: () {
                            showCropCategoriesDialog(
                                context: context,
                                onChange: (value) {
                                  selectedCropType = value;

                                  cropType.text = value.name;

                                  context.read<CalenderCubit>().getCalender(
                                      id: value.id,
                                      ecologicalRegion:
                                          _selectedEcologicalRegion?.en ?? "");

                                  setState(() {});
                                });
                          },
                        )),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.hp, horizontal: 0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                              ),
                              itemCount: Month.monthList.length,
                              itemBuilder: (context, index) {
                                return MonthCardWidget(
                                  color: calenderMonthModel[index].color,
                                  month: Month.monthList[index],
                                  timePeriod:
                                      calenderMonthModel[index].timePeriod,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10.wp),
                          Expanded(
                              flex: 1,
                              child: BlocConsumer<CalenderCubit, CommonState>(
                                listener: (context, state) {
                                  calenderMonthModel =
                                      RepositoryProvider.of<CalenderRepository>(
                                              context)
                                          .calenderMonthModel;
                                  _selectedCropId =
                                      calednerList.values.toList().isNotEmpty
                                          ? calednerList.values.toList()[0].id
                                          : "";
                                  setState(() {});

                                  context
                                      .read<CropIndexChangeCubit>()
                                      .onCropIndexChange(_selectedCropId);
                                },
                                builder: (context, state) {
                                  if (state is CommonLoading) {
                                    return const ListViewPlaceHolder(
                                      horizontalPadding: 0,
                                    );
                                  } else if (state is CommonError) {
                                    return CommonErrorWidget(
                                        message: state.message);
                                  } else if (state is CommonNoData) {
                                    return const CommonNoDataWidget();
                                  } else if (state
                                      is CommonDataFetchSuccess<String>) {
                                    return SingleChildScrollView(
                                      controller: _scrollController,
                                      child: Column(
                                        children: [
                                          ...List.generate(state.data.length,
                                              (index) {
                                            final data =
                                                calednerList[state.data[index]];

                                            if (data != null) {
                                              return CropItemCard(
                                                data: data,
                                                onChange: () {
                                                  _onChangeIndex(data.id);

                                                  context
                                                      .read<
                                                          CropIndexChangeCubit>()
                                                      .onCropIndexChange(
                                                          _selectedCropId);
                                                },
                                                id: data.id,
                                                selectedId: _selectedCropId,
                                              );
                                            } else {
                                              return SizedBox();
                                            }
                                          })
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ))
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //     height:
                  //         50.hp + MediaQuery.of(context).viewPadding.bottom),
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}
