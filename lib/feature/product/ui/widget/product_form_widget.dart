import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/custom_locale.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/model/photos.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/form_validator.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/bottom_navigation_bar_wrapper.dart';
import 'package:krishi_hub/common/widget/button/custom_outline_button.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/media_field.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/feature/crop_type/cubit/get_crop_by_categoryId_cubit.dart';
import 'package:krishi_hub/feature/product/cubit/create_product_cubit.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';
import 'package:krishi_hub/feature/product/model/product_model.dart';
import 'package:krishi_hub/feature/product/ui/page/product_page.dart';
import 'package:krishi_hub/feature/crop_type/ui/widget/crop_categories_dialog.dart';
import 'package:krishi_hub/feature/crop_type/ui/widget/show_crops_dialog.dart';

class ProductFormWidget extends StatefulWidget {
  final ProductModel? productModel;
  const ProductFormWidget({
    super.key,
    this.productModel,
  });

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController category = TextEditingController();
  TextEditingController product = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController estimatedPricePerUnit = TextEditingController();
  TextEditingController productionDate = TextEditingController();
  TextEditingController description = TextEditingController();

  List<ValueNotifier<Photos>> alreadyUploadedMedia = [];

  List<ValueNotifier<File>> media = [];

  List<Photos> deletedMedia = [];

  CropTypeModel? categoryModel;
  CropTypeModel? productModel;

  bool alreadyValidate = false;

  DateTime? date;

  void validateField() {
    if (alreadyValidate) {
      _formKey.currentState!.validate();
    }
  }

  _onSubmit() {
    setState(() {
      alreadyValidate = true;
    });

    if (_formKey.currentState!.validate()) {
      if (widget.productModel == null) {
        context.read<CreateProductCubit>().createProduct(
              productionDate: productionDate.text,
              estimatedPricePerUnit: int.parse(estimatedPricePerUnit.text),
              quantity: int.parse(quantity.text),
              unit: unit.text,
              description: description.text,
              category: categoryModel!.id,
              title: productModel!.id,
              media: media.map((e) => e.value).toList(),
            );
      } else {
        context.read<CreateProductCubit>().updateProduct(
              productId: widget.productModel!.id,
              productionDate: productionDate.text,
              estimatedPricePerUnit: int.parse(estimatedPricePerUnit.text),
              quantity: int.parse(quantity.text),
              unit: unit.text,
              description: description.text,
              category: categoryModel!.id,
              title: productModel!.id,
              media: media.map((e) => e.value).toList(),
              mediaId: widget.productModel!.media?.id,
              deletedMedia: deletedMedia,
            );
      }
    }
  }

  _loadInitialData() {
    if (widget.productModel != null) {
      category.text = widget.productModel!.crops.type.name;
      product.text = widget.productModel!.crops.name;
      unit.text = widget.productModel!.unit;
      quantity.text = widget.productModel!.quantity.toString();
      estimatedPricePerUnit.text =
          widget.productModel!.estimatedPriceperunit.toString();
      productionDate.text = widget.productModel!.productionDate;
      description.text = widget.productModel!.description;
      if (widget.productModel!.media != null) {
        alreadyUploadedMedia = widget.productModel!.media!.medias
            .map((e) => ValueNotifier(e))
            .toList();
      }

      categoryModel = widget.productModel!.crops.type;
      productModel = CropTypeModel(
        id: widget.productModel!.crops.id,
        name: widget.productModel!.crops.name,
      );

      setState(() {});
    }
  }

  @override
  void initState() {
    _loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<CreateProductCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }

        if (state is CommonSuccess) {
          if (widget.productModel == null) {
            CustomToast.success(
                message: LocaleKeys.productCreateSuccessfully.tr());
            NavigationService.pop();
          } else {
            CustomToast.success(
                message: LocaleKeys.productUpdateSuccessfully.tr());

            NavigationService.popUntilFirstPage();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.addProduct.tr(),
          ),
          bottomNavigationBar: widget.productModel != null
              ? const SizedBox()
              : BottomNavigationBarWrapper(
                  child: Container(
                    color: CustomTheme.lightGray,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                              CustomTheme.symmetricHozPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomOutlineButton(
                                name: LocaleKeys.viewProducts.tr(),
                                onPressed: () {
                                  NavigationService.push(
                                      target: const ProductPage());
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
                ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(CustomTheme.symmetricHozPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20.hp),
                    CustomTextField(
                      labelText: LocaleKeys.category.tr(),
                      isReadOnly: true,
                      controller: category,
                      isRequired: true,
                      validator: (value) {
                        return FormValidator.validateFieldNotEmpty(
                            value, LocaleKeys.category.tr());
                      },
                      onTap: () {
                        showCropCategoriesDialog(
                            context: context,
                            onChange: (value) {
                              setState(() {
                                categoryModel = value;
                                productModel = null;
                                product.clear();
                              });

                              category.text = value.name;
                              validateField();
                              context
                                  .read<GetCropByCategoryIdCubit>()
                                  .getCropByCategoryId(value.id);
                            });
                      },
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.productTitle.tr(),
                      isReadOnly: true,
                      isRequired: true,
                      controller: product,
                      validator: (value) {
                        return FormValidator.validateFieldNotEmpty(
                            value, LocaleKeys.productTitle.tr());
                      },
                      onTap: () {
                        showCropsDialog(
                            cropId: categoryModel?.id,
                            context: context,
                            onChange: (value) {
                              setState(() {
                                productModel = value;
                              });

                              product.text = value.name;
                              validateField();
                            });
                      },
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.unit.tr(),
                      controller: unit,
                      isRequired: true,
                      onChanged: (value) {
                        validateField();
                      },
                      validator: (value) {
                        return FormValidator.validateFieldNotEmpty(
                            value, LocaleKeys.unit.tr());
                      },
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.quantity.tr(),
                      isRequired: true,
                      controller: quantity,
                      textInputType: TextInputType.number,
                      textInputFormatterList: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value) {
                        validateField();
                      },
                      validator: (value) {
                        return FormValidator.validateFieldNotEmpty(
                            value, LocaleKeys.quantity.tr());
                      },
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.estimatedPricePerUnit.tr(),
                      controller: estimatedPricePerUnit,
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
                            value, LocaleKeys.estimatedPricePerUnit.tr());
                      },
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.productionDate.tr(),
                      textInputAction: TextInputAction.next,
                      isRequired: true,
                      controller: productionDate,
                      isReadOnly: true,
                      onTap: () async {
                        final DateTime currentDate = DateTime.now();
                        date = await showDatePicker(
                          context: context,
                          initialDate: currentDate,
                          locale: CustomLocale.nepali,
                          firstDate: DateTime(1914),
                          lastDate: currentDate,
                        );
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        if (date != null) {
                          productionDate.text = formatter.format(date!);
                        }
                        validateField();
                      },
                      validator: (value) {
                        return FormValidator.validateFieldNotEmpty(
                            value, LocaleKeys.productionDate.tr());
                      },
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.description.tr(),
                      controller: description,
                      isRequired: false,
                      maxLines: 4,
                      onChanged: (value) {
                        validateField();
                      },
                      // validator: (value) {
                      //   return FormValidator.validateFieldNotEmpty(
                      //       value, LocaleKeys.description.tr());
                      // },
                    ),
                    MultipleMediaFieldWidget(
                      alreadyUploadedMedia: alreadyUploadedMedia,
                      media: media,
                      deleteAlreadyUploadMedia: (value) {
                        deletedMedia.add(value);
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 24.hp),
                    CustomRoundedButton(
                      isLoading: state is CommonLoading,
                      title: widget.productModel == null
                          ? LocaleKeys.submit.tr()
                          : LocaleKeys.update.tr(),
                      onPressed: _onSubmit,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 34.hp),
                    // if (widget.productModel == null)
                    //   SizedBox(
                    //     height: MediaQuery.of(context).padding.bottom + 50.hp,
                    //   )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
