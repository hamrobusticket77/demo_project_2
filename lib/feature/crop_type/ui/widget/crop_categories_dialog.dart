import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/crop_type/cubit/get_all_crop_categories_cubit.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';
import 'package:krishi_hub/common/widget/common_drop_down_wrapper.dart';

showCropCategoriesDialog({
  required BuildContext context,
  required ValueChanged<CropTypeModel> onChange,
}) {
  showDialog(
      context: context,
      builder: ((context) => CropTypeDialog(
            onChange: onChange,
          )));
}

class CropTypeDialog extends StatefulWidget {
  final ValueChanged<CropTypeModel> onChange;

  const CropTypeDialog({super.key, required this.onChange});

  @override
  State<CropTypeDialog> createState() => _ProgramDialogState();
}

class _ProgramDialogState extends State<CropTypeDialog> {
  @override
  void initState() {
    final bloc = context.read<GetAllCropCategoriesCubit>();

    if (bloc.state is CommonLoading ||
        bloc.state is CommonDataFetchSuccess<CropTypeModel>) {
    } else {
      bloc.getAllCropCategories();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonDropDownWrapper(
      title: LocaleKeys.category.tr(),
      child: BlocBuilder<GetAllCropCategoriesCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoading) {
            return const ListViewPlaceHolder(
              horizontalPadding: 0,
            );
          } else if (state is CommonNoData) {
            return const CommonNoDataWidget();
          } else if (state is CommonError) {
            return Material(child: Text(state.message));
          } else if (state is CommonDataFetchSuccess<CropTypeModel>) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(state.data.length, (index) {
                  final data = state.data[index];

                  if (data != null) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Material(
                          borderRadius: BorderRadius.circular(5),
                          child: InkWell(
                            onTap: () {
                              widget.onChange(data);
                              NavigationService.pop();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  child: Text(
                                    data.name,
                                    style: textTheme.bodyLarge,
                                  ),
                                ),
                                const Divider()
                              ],
                            ),
                          )),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
