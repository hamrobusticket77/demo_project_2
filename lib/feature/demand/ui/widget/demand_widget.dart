import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/model/fiscal_year.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/form_validator.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/demand/cubit/seed_demand_cubit.dart';
import 'package:krishi_hub/feature/demand/model/demand_model.dart';
import 'package:krishi_hub/feature/demand/model/demand_param_model.dart';
import 'package:krishi_hub/feature/project/cubit/fiscal_year_cubit.dart';
import 'package:krishi_hub/feature/project/model/program_model.dart';
import 'package:krishi_hub/feature/project/model/project_model.dart';

import 'package:krishi_hub/feature/project/ui/widget/fiscal_year_dialog.dart';
import 'package:krishi_hub/feature/project/ui/widget/program_dialog.dart';
import 'package:krishi_hub/feature/project/ui/widget/project_dialog.dart';

class DemandWidget extends StatefulWidget {
  final DemandModel? demand;
  const DemandWidget({
    super.key,
    this.demand,
  });

  @override
  State<DemandWidget> createState() => _DemandWidgetState();
}

class _DemandWidgetState extends State<DemandWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController fiscalYear = TextEditingController();
  TextEditingController program = TextEditingController();
  TextEditingController project = TextEditingController();

  FiscalYear? fiscalYearModel;
  ProgramModel? programModel;
  ProjectModel? projectModel;

  List<DemandDetailsParamModel> demandDetails = [];

  bool alreadyValidate = false;

  void validateField() {
    if (alreadyValidate) {
      formKey.currentState!.validate();
    }
  }

  void onSubmit() {
    setState(() {
      alreadyValidate = true;
    });
    if (formKey.currentState!.validate()) {
      if (widget.demand == null) {
        context.read<SeedDemandCubit>().seedDemand(
              fiscalYearId: fiscalYearModel!.id,
              programId: programModel!.id,
              projectId: projectModel!.id,
              demandDetails: demandDetails,
            );
      } else {
        context.read<SeedDemandCubit>().updateDemand(
            fiscalYearId: fiscalYearModel!.id,
            programId: programModel!.id,
            projectId: projectModel!.id,
            demandDetails: demandDetails,
            id: widget.demand!.id);
      }
    }
  }

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  void loadInitialData() {
    final fiscalYearCubit = context.read<FiscalYearCubit>().state;

    if (widget.demand != null) {
      fiscalYear.text = widget.demand!.fiscalYear.fiscalYear;
      program.text = widget.demand!.program.title;
      project.text = widget.demand!.project.title;

      fiscalYearModel = FiscalYear.fromMap(widget.demand!.fiscalYear.toMap());
      // programModel = ProgramModel.fromMap(widget.demand!.program.toJson());
      // projectModel = ProjectModel.fromMap(widget.demand!.project.toJson());

      // for (var element in widget.demand!.demand) {
      //   demandDetails.add(DemandDetailsParamModel(
      //     seedCategory: seed_category.SeedCategoryModel(
      //         id: element.category.id, name: element.category.name, seed: []),
      //     seed:
      //         seed_category.Seed(id: element.seed.id, name: element.seed.name),
      //     demandQuantity: element.quantity,
      //   ));
      // }
      setState(() {});
    } else {
      if (fiscalYearCubit is CommonStateSuccess<FiscalYear>) {
        fiscalYear.text = fiscalYearCubit.data.fiscalYear;

        fiscalYearModel = fiscalYearCubit.data;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<SeedDemandCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        } else if (state is CommonSuccess) {
          if (widget.demand == null) {
            CustomToast.success(
                message: LocaleKeys.subsidyAddSuccessfully.tr());
          } else {
            CustomToast.success(message: "Demand Update Successfully");
          }
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.seedSubsidy.tr(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding.wp),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.hp),
                  CustomTextField(
                    labelText: LocaleKeys.fiscalYear.tr(),
                    isReadOnly: true,
                    controller: fiscalYear,
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.fiscalYear.tr());
                    },
                    onTap: () {
                      program.clear();

                      programModel = null;
                      project.clear();
                      projectModel = null;
                      fiscalYearDialog(
                          context: context,
                          onChange: (value) {
                            fiscalYearModel = value;
                            fiscalYear.text = value.fiscalYear;

                            validateField();
                          });
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.program.tr(),
                    isReadOnly: true,
                    controller: program,
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.program.tr());
                    },
                    onTap: () {
                      projectModel = null;
                      project.clear();
                      programDialog(
                          fiscalYearId: fiscalYearModel?.id ?? "",
                          context: context,
                          onChange: (value) {
                            programModel = value;
                            program.text = value.title;
                            validateField();
                          });
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.project.tr(),
                    isReadOnly: true,
                    controller: project,
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.project.tr());
                    },
                    onTap: () {
                      projectDialog(
                          programId: programModel?.id ?? "",
                          context: context,
                          onChange: (value) {
                            projectModel = value;
                            project.text = value.title;
                            validateField();
                          });
                    },
                  ),
                  SizedBox(height: 20.hp),
                  Text(
                    LocaleKeys.addSubsidyDetails.tr(),
                    style: textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(demandDetails.length, (index) {
                    return CommonCardWrapper(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 8),
                        child: Column(
                          children: [
                            TextTileWidget(
                              title: LocaleKeys.seedCategory.tr(),
                              subTitle: demandDetails[index].seedCategory.name,
                            ),
                            TextTileWidget(
                              title: LocaleKeys.seedname.tr(),
                              subTitle: demandDetails[index].seed.name,
                            ),
                            TextTileWidget(
                              title: LocaleKeys.subsidyDetails.tr(),
                              subTitle: demandDetails[index]
                                  .demandQuantity
                                  .toString(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomRoundedButton(
                                  elevation: 0,
                                  verticalPadding: 5,
                                  color: CustomTheme.lightGray,
                                  textColor: CustomTheme.red,
                                  outlineColor: CustomTheme.red,
                                  onPressed: () {
                                    demandDetails.removeAt(index);
                                    setState(() {});
                                  },
                                  title: LocaleKeys.remove.tr(),
                                  icon: Icons.delete_outline_outlined,
                                  iconColor: CustomTheme.red,
                                )
                              ],
                            )
                          ],
                        ));
                  }),
                  SizedBox(height: 10.hp),
                  Row(
                    children: [
                      SizedBox(
                        // width: 2,
                        child: CustomRoundedButton(
                          title: (demandDetails.isNotEmpty)
                              ? LocaleKeys.add.tr()
                              : LocaleKeys.addSubsidyDetails.tr(),
                          borderRadius: 5,
                          icon: Icons.add_chart_outlined,
                          iconColor: Theme.of(context).primaryColor,
                          outlineColor: Theme.of(context).primaryColor,
                          color: CustomTheme.white,
                          verticalPadding: 8,
                          textColor: CustomTheme.black,
                          elevation: 0,
                          onPressed: () async {
                            // await addDemandDialog(
                            //   context: context,
                            //   demandDetails: null,
                            // ).then((value) {
                            //   if (value != null) {
                            //     demandDetails.add(value);
                            //     validateField();
                            //     setState(() {});
                            //   }
                            // });
                          },
                        ),
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                  TextFormField(
                    style: const TextStyle(fontSize: 1),
                    readOnly: true,
                    decoration: const InputDecoration.collapsed(
                      hintText: "",
                    ),
                    validator: (v) {
                      if (demandDetails.isEmpty) {
                        return LocaleKeys.addSubsidyDetails.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24.hp,
                  ),
                  BlocBuilder<SeedDemandCubit, CommonState>(
                    builder: (context, state) {
                      return CustomRoundedButton(
                        title: widget.demand == null
                            ? LocaleKeys.submit.tr()
                            : "Update",
                        onPressed: onSubmit,
                        isLoading: (state is CommonLoading) ? true : false,
                      );
                    },
                  ),
                  SizedBox(
                    height: 24.hp,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
