import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/project/cubit/planing_service_cubit.dart';
import 'package:krishi_hub/feature/project/model/plan_service_model.dart';
import 'package:krishi_hub/feature/project/resource/all_plan_Service_repository.dart';
import 'package:krishi_hub/common/widget/common_drop_down_wrapper.dart';

planingserviceDialog({
  required BuildContext context,
  required String projectId,
  required ValueChanged<PlanServiceModel> onChange,
}) {
  showDialog(
      context: context,
      builder: ((context) => PlanningserviceDialog(
            onChange: onChange,
            projectId: projectId,
          )));
}

class PlanningserviceDialog extends StatefulWidget {
  final ValueChanged<PlanServiceModel> onChange;
  final String projectId;

  const PlanningserviceDialog(
      {super.key, required this.onChange, required this.projectId});

  @override
  State<PlanningserviceDialog> createState() => _ProgramDialogState();
}

class _ProgramDialogState extends State<PlanningserviceDialog> {
  @override
  void initState() {
    final bloc = context.read<PlaningServiceCubit>();
    bloc.getPlaningService(projectId: widget.projectId);

    if (bloc.state is! CommonLoading || bloc.state is! CommonDataFetchSuccess) {
      bloc.getPlaningService(projectId: widget.projectId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allProgram =
        RepositoryProvider.of<AllPlanServiceRepository>(context).getItems;
    final textTheme = Theme.of(context).textTheme;
    return CommonDropDownWrapper(
      title: LocaleKeys.planningService.tr(),
      child: widget.projectId.isEmpty
          ? Container(
              child: Text(
                LocaleKeys.selectPlanningFirst.tr(),
                textAlign: TextAlign.center,
              ),
            )
          : BlocBuilder<PlaningServiceCubit, CommonState>(
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
                                          data.services,
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
