import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/project/cubit/project_cubit.dart';
import 'package:krishi_hub/feature/project/model/project_model.dart';
import 'package:krishi_hub/feature/project/resource/all_project_repository.dart';
import 'package:krishi_hub/common/widget/common_drop_down_wrapper.dart';

projectDialog({
  required BuildContext context,
  required String programId,
  required ValueChanged<ProjectModel> onChange,
}) {
  showDialog(
      context: context,
      builder: ((context) => ProjectDialog(
            onChange: onChange,
            programId: programId,
          )));
}

class ProjectDialog extends StatefulWidget {
  final ValueChanged<ProjectModel> onChange;
  final String programId;

  const ProjectDialog(
      {super.key, required this.onChange, required this.programId});

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  @override
  void initState() {
    final bloc = context.read<ProjectCubit>();
    bloc.getProject(programId: widget.programId);

    if (bloc.state is! CommonLoading || bloc.state is! CommonDataFetchSuccess) {
      bloc.getProject(programId: widget.programId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allProject =
        RepositoryProvider.of<AllProjectRepository>(context).getItems;
    final textTheme = Theme.of(context).textTheme;
    return CommonDropDownWrapper(
        title: LocaleKeys.project.tr(),
        child: widget.programId.isEmpty
            ? Container(
                child: Text(LocaleKeys.selectProgramFirst.tr(),
                    textAlign: TextAlign.center),
              )
            : BlocBuilder<ProjectCubit, CommonState>(
                builder: (context, state) {
                  if (state is CommonLoading) {
                    return const ListViewPlaceHolder(
                      horizontalPadding: 0,
                    );
                  } else if (state is CommonError) {
                    return Material(
                        child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ));
                  } else if (state is CommonDataFetchSuccess<String>) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(state.data.length, (index) {
                          final data = allProject[state.data[index]];

                          if (data != null) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Material(
                                  color: CustomTheme.white,
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
