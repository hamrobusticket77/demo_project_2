import 'package:flutter/material.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/feature/project/model/sub_category_model.dart';
import 'package:krishi_hub/common/widget/common_drop_down_wrapper.dart';

seedNameDialog({
  required BuildContext context,
  required ValueChanged<SubCategoryModel> onChange,
  required List<SubCategoryModel> seedList,
}) {
  showDialog(
      context: context,
      builder: ((context) => SeedNameDialog(
            onChange: onChange,
            seedList: seedList,
          )));
}

class SeedNameDialog extends StatefulWidget {
  final ValueChanged<SubCategoryModel> onChange;
  final List<SubCategoryModel> seedList;

  const SeedNameDialog(
      {super.key, required this.onChange, required this.seedList});

  @override
  State<SeedNameDialog> createState() => _SeedNameDialogState();
}

class _SeedNameDialogState extends State<SeedNameDialog> {
  @override
  void initState() {
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
    final textTheme = Theme.of(context).textTheme;
    return CommonDropDownWrapper(
        title: "Seed Name",
        child: Column(
          children: [
            if (widget.seedList.isEmpty) const CommonNoDataWidget(),
            ...List.generate(widget.seedList.length, (index) {
              final data = widget.seedList[index];

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
            })
          ],
        ));
  }
}
