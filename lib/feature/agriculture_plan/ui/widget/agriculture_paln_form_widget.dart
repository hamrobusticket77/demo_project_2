import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/model/fiscal_year.dart';
import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/model/photos.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/form_validator.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/media_field.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/feature/agriculture_plan/constant/farmer_type.dart';
import 'package:krishi_hub/feature/agriculture_plan/cubit/agriculture_cubit.dart';
import 'package:krishi_hub/feature/agriculture_plan/model/agriculture_plan_model.dart';
import 'package:krishi_hub/feature/agriculture_plan/ui/widget/farmer_type_dialog.dart';
import 'package:krishi_hub/feature/project/cubit/fiscal_year_cubit.dart';
import 'package:krishi_hub/feature/project/model/plan_service_model.dart';
import 'package:krishi_hub/feature/project/model/program_model.dart';
import 'package:krishi_hub/feature/project/model/project_model.dart';
import 'package:krishi_hub/feature/project/ui/widget/fiscal_year_dialog.dart';
import 'package:krishi_hub/feature/project/ui/widget/plan_Service_dialog.dart';
import 'package:krishi_hub/feature/project/ui/widget/program_dialog.dart';
import 'package:krishi_hub/feature/project/ui/widget/project_dialog.dart';

class AgriculturePlanFormWidget extends StatefulWidget {
  final AgriculturePlanModel? agriculturelistModel;
  const AgriculturePlanFormWidget({super.key, this.agriculturelistModel});

  @override
  State<AgriculturePlanFormWidget> createState() =>
      _AgriculturePlanFormWidgetState();
}

class _AgriculturePlanFormWidgetState extends State<AgriculturePlanFormWidget> {
  TextEditingController fiscalYear = TextEditingController();
  TextEditingController program = TextEditingController();
  TextEditingController project = TextEditingController();
  TextEditingController planningService = TextEditingController();
  TextEditingController farmertype = TextEditingController();
  TextEditingController contactname = TextEditingController();
  TextEditingController benefitted = TextEditingController();
  TextEditingController totalcost = TextEditingController();
  TextEditingController municipalityExpectedCost = TextEditingController();
  TextEditingController landArea = TextEditingController();
  TextEditingController activities = TextEditingController();

  TextEditingController remark = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // List<ValueNotifier<File>> imageList = [];

  // List<Map<String, dynamic>> mediaList = [];

  List<ValueNotifier<Photos>> alreadyUploadedMedia = [];

  List<ValueNotifier<File>> media = [];

  List<Photos> deletedMedia = [];

  FiscalYear? fiscalYearModel;
  ProgramModel? programModel;
  ProjectModel? projectModel;
  PlanServiceModel? planserviceModel;

  MultiLanguage? farmerTypeMultiLan;

  bool alreadyValidate = false;

  // List<String> deletedMedia = [];

  void validateField() {
    if (alreadyValidate) {
      _formKey.currentState!.validate();
    }
  }

  void onSubmit() {
    setState(() {
      alreadyValidate = true;
    });

    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      if (widget.agriculturelistModel == null) {
        context.read<AgricultureCubit>().createAgriculturePlan(
            fiscalYearId: fiscalYearModel!.id,
            program: programModel!.id,
            project: projectModel!.id,
            planningService: planserviceModel!.id,
            farmerType: farmerTypeMultiLan?.en ?? "".toUpperCase(),
            contactPersonName: contactname.text,
            benefittedHHS: benefitted.text,
            totalCost: totalcost.text,
            municipalityExpectedCost: municipalityExpectedCost.text,
            landArea: landArea.text,
            activities: activities.text,
            remarks: remark.text,
            image: media.map((e) => e.value).toList());
      } else {
        context.read<AgricultureCubit>().udpateAgriculturePlan(
              fiscalYearId: widget.agriculturelistModel!.fiscalYear.id,
              program: programModel!.id,
              project: projectModel!.id,
              planningService: planserviceModel!.id,
              farmerType: farmerTypeMultiLan?.en ?? "".toUpperCase(),
              contactPersonName: contactname.text,
              benefittedHHS: benefitted.text,
              totalCost: totalcost.text,
              municipalityExpectedCost: municipalityExpectedCost.text,
              landArea: landArea.text,
              activities: activities.text,
              remarks: remark.text,
              image: media.map((e) => e.value).toList(),
              deletedMedia: deletedMedia,
              id: widget.agriculturelistModel!.id,
              mediaId: widget.agriculturelistModel!.media?.id,
            );
      }
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    final fiscalYearCubit = context.read<FiscalYearCubit>().state;

    if (widget.agriculturelistModel != null) {
      fiscalYear.text = widget.agriculturelistModel!.fiscalYear.fiscalYear;
      program.text = widget.agriculturelistModel!.program.title;
      project.text = widget.agriculturelistModel!.project.title;
      planningService.text =
          widget.agriculturelistModel!.planningService.services;
      farmertype.text = widget.agriculturelistModel!.farmerType;
      contactname.text = widget.agriculturelistModel!.contactPersonName;
      benefitted.text = widget.agriculturelistModel!.benefittedHHS.toString();
      totalcost.text = widget.agriculturelistModel!.totalCost.toString();
      municipalityExpectedCost.text =
          widget.agriculturelistModel!.municipalityExpectedCost.toString();
      landArea.text = widget.agriculturelistModel!.landArea.toString();
      activities.text = widget.agriculturelistModel!.activities.toString();
      remark.text = widget.agriculturelistModel!.remarks.toString();

      debugPrint(widget.agriculturelistModel!.fiscalYear.fiscalYear);
      fiscalYearModel = FiscalYear(
          id: widget.agriculturelistModel!.fiscalYear.id,
          fiscalYear: widget.agriculturelistModel!.fiscalYear.fiscalYear,
          endDate: widget.agriculturelistModel!.fiscalYear.endDate,
          isActive: widget.agriculturelistModel!.fiscalYear.isActive,
          startDate: widget.agriculturelistModel!.fiscalYear.startDate);
      programModel = ProgramModel(
        id: widget.agriculturelistModel!.program.id,
        title: widget.agriculturelistModel!.program.title,
        createdAt: "",
        deletedAt: "",
        fiscalYear: FiscalYear.fromMap({}),
      );
      projectModel = ProjectModel(
        id: widget.agriculturelistModel!.project.id,
        title: widget.agriculturelistModel!.project.title,
        fiscalYear: FiscalYear.fromMap({}),
        program: ProgramModel.fromMap({}),
        planningService: PlanServiceModel.fromMap({}),
      );
      planserviceModel = PlanServiceModel(
          id: widget.agriculturelistModel!.planningService.id,
          services: widget.agriculturelistModel!.planningService.services);
      farmerTypeMultiLan =
          GroupType.getFarmerMultiLang(widget.agriculturelistModel!.farmerType);

      if (widget.agriculturelistModel!.media != null) {
        alreadyUploadedMedia = widget.agriculturelistModel!.media!.medias
            .map((e) => ValueNotifier(e))
            .toList();
      }
    } else {
      if (fiscalYearCubit is CommonStateSuccess<FiscalYear>) {
        fiscalYear.text = fiscalYearCubit.data.fiscalYear;

        fiscalYearModel = fiscalYearCubit.data;
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    fiscalYear.dispose();
    program.dispose();
    project.dispose();
    planningService.dispose();
    farmertype.dispose();
    contactname.dispose();
    benefitted.dispose();
    totalcost.dispose();
    municipalityExpectedCost.dispose();
    landArea.dispose();
    activities.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<AgricultureCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccess) {
          CustomToast.success(
              message: (widget.agriculturelistModel == null)
                  ? LocaleKeys.programSubmitedSucessfully.tr()
                  : LocaleKeys.programUpdateSucessfully.tr());
          Navigator.pop(context, true);
        }

        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.agricultureplan.tr(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding.wp),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: LocaleKeys.fiscalYear.tr(),
                    isReadOnly: true,
                    controller: fiscalYear,
                    isRequired: true,
                    onTap: () {
                      program.clear();
                      programModel = null;

                      project.clear();
                      projectModel = null;

                      planningService.clear();
                      planserviceModel = null;

                      fiscalYearDialog(
                          context: context,
                          onChange: (value) {
                            fiscalYearModel = value;
                            fiscalYear.text = value.fiscalYear;
                            validateField();
                          });
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.fiscalYear.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.program.tr(),
                    isReadOnly: true,
                    controller: program,
                    isRequired: true,
                    onTap: () {
                      project.clear();
                      projectModel = null;

                      planningService.clear();
                      planserviceModel = null;

                      programDialog(
                          fiscalYearId: fiscalYearModel?.id ?? "",
                          context: context,
                          onChange: (value) {
                            programModel = value;
                            program.text = value.title;
                            validateField();
                          });
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.program.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.project.tr(),
                    isReadOnly: true,
                    controller: project,
                    isRequired: true,
                    onTap: () {
                      planningService.clear();
                      planserviceModel = null;
                      projectDialog(
                          programId: programModel?.id ?? "",
                          context: context,
                          onChange: (value) {
                            projectModel = value;
                            project.text = value.title;
                            validateField();
                          });
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.project.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.planningservice.tr(),
                    isReadOnly: true,
                    controller: planningService,
                    onTap: () {
                      planserviceModel = null;
                      planningService.clear();
                      planingserviceDialog(
                          projectId: projectModel?.id ?? "",
                          context: context,
                          onChange: (value) {
                            planserviceModel = value;
                            planningService.text = value.services;
                            validateField();
                          });
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.planningservice.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.framertype.tr(),
                    isReadOnly: true,
                    controller: farmertype,
                    isRequired: true,
                    onTap: () {
                      // farmertype.clear();

                      farmerTypeDialog(
                          context: context,
                          onChange: (value) {
                            farmertype.text = value.localize();
                            farmerTypeMultiLan = value;
                            validateField();
                          });
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.planningservice.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.contactpersonname.tr(),
                    controller: contactname,
                    isRequired: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      validateField();
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.contactpersonname.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.benefittedhhs.tr(),
                    controller: benefitted,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textInputFormatterList: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    isRequired: true,
                    onChanged: (value) {
                      validateField();
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.benefittedhhs.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.totalcost.tr(),
                    controller: totalcost,
                    textInputAction: TextInputAction.next,
                    isRequired: true,
                    textInputType: TextInputType.number,
                    textInputFormatterList: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      validateField();
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.totalcost.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.municipalityexpectedcost.tr(),
                    controller: municipalityExpectedCost,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textInputFormatterList: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    isRequired: true,
                    onChanged: (value) {
                      validateField();
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.municipalityexpectedcost.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.landArea.tr(),
                    controller: landArea,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    isRequired: true,
                    textInputFormatterList: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      validateField();
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.landArea.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.activities.tr(),
                    controller: activities,
                    textInputAction: TextInputAction.newline,
                    maxLines: 4,
                    isRequired: true,
                    onChanged: (value) {
                      validateField();
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.activities.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.remarks.tr(),
                    controller: remark,
                    isRequired: true,
                    textInputAction: TextInputAction.newline,
                    maxLines: 4,
                    onChanged: (value) {
                      validateField();
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.remarks.tr());
                    },
                  ),
                  MultipleMediaFieldWidget(
                    alreadyUploadedMedia: alreadyUploadedMedia,
                    media: media,
                    deleteAlreadyUploadMedia: (value) {
                      deletedMedia.add(value);
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 30.hp),
                  BlocBuilder<AgricultureCubit, CommonState>(
                    builder: (context, state) {
                      return CustomRoundedButton(
                        isLoading: (state is CommonLoading) ? true : false,
                        title: (widget.agriculturelistModel == null)
                            ? LocaleKeys.submit.tr()
                            : LocaleKeys.update.tr(),
                        onPressed: onSubmit,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 34,
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
