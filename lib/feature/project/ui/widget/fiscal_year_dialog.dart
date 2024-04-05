import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/model/fiscal_year.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/project/cubit/fiscal_year_cubit.dart';
import 'package:krishi_hub/common/widget/common_drop_down_wrapper.dart';

fiscalYearDialog({
  required BuildContext context,
  required ValueChanged<FiscalYear> onChange,
}) {
  showDialog(
      context: context,
      builder: ((context) => FiscalYearDialog(
            onChange: onChange,
          )));
}

class FiscalYearDialog extends StatefulWidget {
  final ValueChanged<FiscalYear> onChange;

  const FiscalYearDialog({
    super.key,
    required this.onChange,
  });

  @override
  State<FiscalYearDialog> createState() => _FiscalYearDialogState();
}

class _FiscalYearDialogState extends State<FiscalYearDialog> {
  @override
  void initState() {
    final bloc = context.read<FiscalYearCubit>();
    if (bloc.state is CommonLoading || bloc.state is CommonStateSuccess) {
    } else {
      bloc.getCurrentFiscalYear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonDropDownWrapper(
        title: "Fiscal Year",
        child: BlocBuilder<FiscalYearCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoading) {
              return const ListViewPlaceHolder(
                horizontalPadding: 0,
                numberofItem: 1,
              );
            } else if (state is CommonError) {
              return Material(child: Text(state.message));
            } else if (state is CommonStateSuccess<FiscalYear>) {
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Material(
                            // color: CustomTheme.lightGray,
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              onTap: () {
                                widget.onChange(state.data);
                                NavigationService.pop();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    child: Text(
                                      state.data.fiscalYear,
                                      style: textTheme.bodyLarge,
                                    ),
                                  ),
                                  const Divider()
                                ],
                              ),
                            )),
                      ),
                    ]

                    // List.generate(state.data.length, (index) {
                    //   final data = fiscalyear[state.data[index]];

                    //   if (data != null) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(bottom: 12),
                    //       child: Material(
                    //           // color: CustomTheme.lightGray,
                    //           borderRadius: BorderRadius.circular(5),
                    //           child: InkWell(
                    //             onTap: () {
                    //               widget.onChange(data);
                    //               NavigationService.pop();
                    //             },
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.stretch,
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       vertical: 12, horizontal: 10),
                    //                   child: Text(
                    //                     data.fiscalYear,
                    //                     style: textTheme.bodyLarge,
                    //                   ),
                    //                 ),
                    //                 const Divider()
                    //               ],
                    //             ),
                    //           )),
                    //     );
                    //   } else {
                    //     return const SizedBox();
                    //   }
                    // }),

                    ),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
