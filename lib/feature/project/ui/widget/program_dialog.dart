import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/project/cubit/program_cubit.dart';
import 'package:krishi_hub/feature/project/model/program_model.dart';
import 'package:krishi_hub/feature/project/resource/all_program_repository.dart';
import 'package:krishi_hub/common/widget/common_drop_down_wrapper.dart';

programDialog({
  required BuildContext context,
  required String fiscalYearId,
  required ValueChanged<ProgramModel> onChange,
}) {
  showDialog(
      context: context,
      builder: ((context) => ProgramDialog(
            onChange: onChange,
            fiscalYearId: fiscalYearId,
          )));
}

class ProgramDialog extends StatefulWidget {
  final ValueChanged<ProgramModel> onChange;
  final String fiscalYearId;

  const ProgramDialog(
      {super.key, required this.onChange, required this.fiscalYearId});

  @override
  State<ProgramDialog> createState() => _ProgramDialogState();
}

class _ProgramDialogState extends State<ProgramDialog> {
  @override
  void initState() {
    final bloc = context.read<ProgramCubit>();
    bloc.getProgram(fiscalYearId: widget.fiscalYearId);

    if (bloc.state is! CommonLoading || bloc.state is! CommonDataFetchSuccess) {
      bloc.getProgram(fiscalYearId: widget.fiscalYearId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allProgram =
        RepositoryProvider.of<AllProgramRepository>(context).getItems;
    final textTheme = Theme.of(context).textTheme;
    return CommonDropDownWrapper(
        title: LocaleKeys.program.tr(),
        child: widget.fiscalYearId.isEmpty
            ? Container(
                child: Text(
                  LocaleKeys.selectFiscalYearFirst.tr(),
                  textAlign: TextAlign.center,
                ),
              )
            : BlocBuilder<ProgramCubit, CommonState>(
                builder: (context, state) {
                  if (state is CommonLoading) {
                    return const ListViewPlaceHolder(
                      horizontalPadding: 0,
                    );
                  } else if (state is CommonNoData) {
                    return const CommonNoDataWidget();
                  } else if (state is CommonError) {
                    return Material(child: Text(state.message));
                  } else if (state is CommonDataFetchSuccess<String>) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(state.data.length, (index) {
                          final data = allProgram[state.data[index]];

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 10),
                                          child: Text(
                                            data.title,
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
