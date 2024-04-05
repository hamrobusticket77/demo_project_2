import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/project/cubit/seed_category_cubit.dart';
import 'package:krishi_hub/feature/project/model/seed_category_model.dart';
import 'package:krishi_hub/feature/project/resource/all_seed_category_repository.dart';
import 'package:krishi_hub/common/widget/common_drop_down_wrapper.dart';

seedCategoryDialog({
  required BuildContext context,
  required ValueChanged<SeedCategoryModel> onChange,
}) {
  showDialog(
      context: context,
      builder: ((context) => SeedCategoryDialog(
            onChange: onChange,
          )));
}

class SeedCategoryDialog extends StatefulWidget {
  final ValueChanged<SeedCategoryModel> onChange;

  const SeedCategoryDialog({super.key, required this.onChange});

  @override
  State<SeedCategoryDialog> createState() => _SeedCategoryDialogState();
}

class _SeedCategoryDialogState extends State<SeedCategoryDialog> {
  @override
  void initState() {
    final bloc = context.read<SeedCategoryCubit>();
    bloc.getSeedCategory();

    // if (bloc.state is! CommonLoading || bloc.state is! CommonDataFetchSuccess) {
    //   bloc.getSeedCategory();
    // }
    super.initState();
  }

  // Timer? timer;
  // void _search(String searchSlug) {
  //   if (timer != null && timer!.isActive) {
  //     timer?.cancel();
  //   }
  //   timer = Timer(const Duration(milliseconds: 10), () {
  //     searchDistrcit(searchSlug);
  //   });
  // }

  // searchDistrcit(String? searchSlug) {
  //   context.read<GetDistrictCubit>().searchDistrict(searchSlug?.trim());
  // }

  @override
  Widget build(BuildContext context) {
    final allProject =
        RepositoryProvider.of<AllSeedCategoryRepository>(context).getItems;
    final textTheme = Theme.of(context).textTheme;
    return CommonDropDownWrapper(
        title: "Seed Category",
        child: BlocBuilder<SeedCategoryCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoading) {
              return const ListViewPlaceHolder(
                horizontalPadding: 0,
              );
            } else if (state is CommonError) {
              return Material(child: Text(state.message));
            } else if (state is CommonDataFetchSuccess<String>) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(state.data.length, (index) {
                    final data = allProject[state.data[index]];

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
                                mainAxisSize: MainAxisSize.min,
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
        ));
  }
}
