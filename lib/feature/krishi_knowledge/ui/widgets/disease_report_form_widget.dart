import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/form_validator.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_outline_button.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/media_field.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/feature/crop_type/cubit/get_crop_by_categoryId_cubit.dart';
import 'package:krishi_hub/feature/crop_type/ui/widget/crop_categories_dialog.dart';
import 'package:krishi_hub/feature/crop_type/ui/widget/show_crops_dialog.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/disease_report_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/pages/disease_report_view_page.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';

class DiseaseReportWidget extends StatefulWidget {
  const DiseaseReportWidget({super.key});

  @override
  State<DiseaseReportWidget> createState() => _DiseaseReportWidgetState();
}

class _DiseaseReportWidgetState extends State<DiseaseReportWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController selectCategory = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController topic = TextEditingController();
  TextEditingController description = TextEditingController();
  List<ValueNotifier<File>> imageList = [];
  List<Map<String, dynamic>> mediaList = [];
  bool alreadyValidate = false;

  AgricultureName? agricultureName;

  List<String> deletedMedia = [];

  void validateField() {
    if (alreadyValidate) {
      _formKey.currentState!.validate();
    }
  }

  // String categoryId = "";
  // String cropId = "";

  CropTypeModel? categoryModel;
  CropTypeModel? cropModel;

  void onSubmit() {
    setState(() {
      alreadyValidate = true;
    });

    if (_formKey.currentState!.validate()) {
      context.read<DiseaseReportCubit>().createDiseaseReport(
          category: categoryModel?.id.toString() ?? "",
          crops: cropModel?.id.toString() ?? "",
          title: topic.text,
          description: description.text,
          image: imageList.map((e) => e.value).toList());
    }
  }

  @override
  void initState() {
    // selectCategory = TextEditingController();
    // nameController = TextEditingController();
    // topic = TextEditingController();
    // description = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    selectCategory.dispose();
    nameController.dispose();
    topic.dispose();
    description.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiseaseReportCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccess) {
          CustomToast.success(
            message: LocaleKeys.reportFormSubmitSuccessfully.tr(),
          );
          NavigationService.pop();
        }

        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.reportDisease.tr(),
        ),
        bottomNavigationBar: Container(
          color: CustomTheme.lightGray,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(CustomTheme.symmetricHozPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomOutlineButton(
                      name: LocaleKeys.viewReportedDisease.tr(),
                      onPressed: () {
                        NavigationService.push(
                            target: const DiseaseReportViewPage());
                      },
                      fontSize: 13,
                      verticalPadding: 5,
                      sufixIcon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding.wp),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: LocaleKeys.selectCategory.tr(),
                    isRequired: true,
                    isReadOnly: true,
                    controller: selectCategory,
                    onChanged: (value) {
                      validateField();
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.selectCategory.tr());
                    },
                    onTap: () {
                      showCropCategoriesDialog(
                          context: context,
                          onChange: (value) {
                            setState(() {
                              categoryModel = value;
                              cropModel = null;
                              nameController.clear();
                            });

                            selectCategory.text = value.name;
                            validateField();
                            context
                                .read<GetCropByCategoryIdCubit>()
                                .getCropByCategoryId(value.id);
                          });
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.selectName.tr(),
                    isRequired: true,
                    isReadOnly: true,
                    controller: nameController,
                    onChanged: (value) {
                      validateField();
                    },
                    onTap: () {
                      showCropsDialog(
                          cropId: categoryModel?.id,
                          context: context,
                          onChange: (value) {
                            setState(() {
                              cropModel = value;
                            });

                            nameController.text = value.name;
                            validateField();
                          });
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.selectName.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.topic.tr(),
                    isRequired: true,
                    controller: topic,
                    onChanged: (value) {
                      validateField();
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.topic.tr());
                    },
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.description.tr(),
                    isRequired: true,
                    controller: description,
                    maxLines: 4,
                    onChanged: (value) {
                      validateField();
                    },
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value, LocaleKeys.description.tr());
                    },
                  ),
                  MultipleMediaFieldWidget(
                    alreadyUploadedMedia: const [],
                    media: imageList,
                    deleteAlreadyUploadMedia: (value) {},
                  ),
                  BlocBuilder<DiseaseReportCubit, CommonState>(
                    builder: (context, state) {
                      return CustomRoundedButton(
                        isLoading: (state is CommonLoading) ? true : false,
                        title: LocaleKeys.submit.tr(),
                        onPressed: onSubmit,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
